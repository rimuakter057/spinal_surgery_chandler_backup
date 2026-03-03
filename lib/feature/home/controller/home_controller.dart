

import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/feature/home/presentation/widgets/dialog_button_widget.dart';
import 'package:chandler_app/feature/home/presentation/widgets/dialog_widget.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeController extends GetxController {
  RxList<HomeModel> homeList = <HomeModel>[].obs;
  RxBool isLoading = false.obs;


  Future<void> fetchNodes({String? parentId,required  BuildContext context}) async {
    isLoading.value = true;

    final uri = parentId == null
        ? ApiUrl.node
        : "${ApiUrl.node}?parent_id=$parentId";

    try {
      final response = await ApiClient.getData(uri);
      if (response.statusCode == 200) {


        final decoded = response.body; // ✅ already Map
        print("========================================${decoded['data']}");
        final List<dynamic> list = decoded['data'] as List<dynamic>;
        homeList.value = list.map((json) => HomeModel.fromJson(json)).toList();
      }


      else {
        homeList.clear();

        CustomSnackbar.error(context, "Failed to fetch nodes");

      }
    } catch (e) {
      homeList.clear();



      CustomSnackbar.error(context, e.toString());
      debugPrint(e.toString());

    }

    isLoading.value = false;
  }







  void onNodeClick(HomeModel model, BuildContext context) async {

    if (model.productInfo != null) {
      context.pushNamed(RoutesPath.mainInformation,

        extra: model.productInfo,
      );
      return;
    }

    await fetchNodes(parentId: model.id, context: context);

    if (homeList.isNotEmpty) {
      if (context.mounted) {
        showNodeDialog(model, context);
      }
    } else {

      CustomSnackbar.error(context, "No more sub-categories found.");
    }
  }






  void showNodeDialog(HomeModel? parent, BuildContext context) {
    if (homeList.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => Obx(() {

        if (homeList.isEmpty) return const SizedBox.shrink();

        return DialogWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: homeList.map((item) {
              final title = item.title ?? 'Untitled';

              return Column(
                children: [
                  DialogButtonWidget(
                    title: title,
                    onTap: () {
                      Navigator.pop(context);
                      onNodeClick(item, context);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }




}



