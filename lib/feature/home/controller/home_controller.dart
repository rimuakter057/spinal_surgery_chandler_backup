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


  ///add cart =====================================
  final RxBool isLoadingCart = false.obs;

  Future<bool> addToCart({
    required String itemId,
    required String itemTitle,
    required String itemImage,
  }) async {
    isLoadingCart.value = true;

    final body = {
      "item_id": itemId,
      "item_title": itemTitle,
      "item_image": itemImage,
      "quantity": 1,
    };

    final response = await ApiClient.postData(ApiUrl.addToCart, body);
    isLoadingCart.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }








///add bookmark=======================================

  RxBool inProgressAddBookMark = false.obs;

  Future<bool> addBookmark({required String id}) async {
    inProgressAddBookMark.value = true;

    final Response response = await ApiClient.postData(ApiUrl.addBookmark, {
      "item_id": id,
    });

    inProgressAddBookMark.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {

      return false;
    }
  }






  ///remove bookmark=======================================

  Future<void> removeBookmark({
    required String itemId,
    required BuildContext context,
  }) async {
    final index = productList.indexWhere((item) => item.id == itemId);
    if (index == -1) return;

    final item = productList[index];

    // Optimistic UI update
  //  item.isBookmarked = false;
    productList.refresh();

    final response = await ApiClient.deleteData(
      ApiUrl.removeBookmark(id: itemId),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      CustomSnackbar.success(context: context, message: "Bookmark removed");
    } else {
      // Revert on failure
     // item.isBookmarked = true;
      productList.refresh();
      CustomSnackbar.error(context, response.statusText ?? 'Something went wrong');
    }
  }






















  /// 🔥 Root list — HomeScreen এর 2টা button এর জন্য
  RxList<HomeModel> rootList = <HomeModel>[].obs;

  /// 🔥 Product list — MainInformationScreen এর জন্য
  RxList<HomeModel> productList = <HomeModel>[].obs;

  RxBool isLoading = false.obs;

  // ─────────────────────────────────────────────────────────
  /// HomeScreen initState এ একবার call হবে
  // ─────────────────────────────────────────────────────────
  Future<void> fetchRootNodes({required BuildContext context}) async {
    isLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.node);
      if (response.statusCode == 200) {
        final List<dynamic> list = response.body['data'] as List<dynamic>;
        rootList.value = list.map((e) => HomeModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(context, "Failed to load");
      }
    } catch (e) {
      CustomSnackbar.error(context, e.toString());
    }
    isLoading.value = false;
  }

  // ─────────────────────────────────────────────────────────
  // MainInformationScreen initState এ call হবে
  // productList এ data আসবে
  // ─────────────────────────────────────────────────────────
  Future<void> fetchProducts({
    required String parentId,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    productList.clear(); // 🔥 প্রতিবার fresh
    try {
      final response =
      await ApiClient.getData("${ApiUrl.node}?parent_id=$parentId");
      if (response.statusCode == 200) {
        final List<dynamic> list = response.body['data'] as List<dynamic>;
        productList.value = list.map((e) => HomeModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(context, "Failed to fetch products");
      }
    } catch (e) {
      CustomSnackbar.error(context, e.toString());
      debugPrint(e.toString());
    }
    isLoading.value = false;
  }

  // ─────────────────────────────────────────────────────────
  // HomeScreen button tap
  // ─────────────────────────────────────────────────────────
  Future<void> onRootItemClick(int index, BuildContext context) async {
    if (rootList.isEmpty || index >= rootList.length) {
      CustomSnackbar.error(context, "Data not loaded yet.");
      return;
    }

    final HomeModel rootItem = rootList[index];

    if (rootItem.type?.toUpperCase() == "PRODUCT") {
      context.pushNamed(RoutesPath.mainInformation, extra: rootItem.id);
      return;
    }

    final List<HomeModel> children = await _fetchChildren(
      parentId: rootItem.id!,
      context: context,
    );

    if (!context.mounted) return;

    if (children.isEmpty) {
      CustomSnackbar.error(context, "No sub-categories found.");
      return;
    }

    final bool allProducts =
    children.every((e) => e.type?.toUpperCase() == "PRODUCT");

    if (allProducts) {
      context.pushNamed(RoutesPath.mainInformation, extra: rootItem.id);
    } else {
      _showDialog(children: children, context: context);
    }
  }

  // ─────────────────────────────────────────────────────────
  // Dialog button tap
  // ─────────────────────────────────────────────────────────
  Future<void> onDialogItemClick(HomeModel item, BuildContext context) async {
    if (item.type?.toUpperCase() == "PRODUCT") {
      context.pushNamed(RoutesPath.mainInformation, extra: item.id);
      return;
    }

    final List<HomeModel> children = await _fetchChildren(
      parentId: item.id!,
      context: context,
    );

    if (!context.mounted) return;

    if (children.isEmpty) {
      CustomSnackbar.error(context, "No sub-categories found.");
      return;
    }

    final bool allProducts =
    children.every((e) => e.type?.toUpperCase() == "PRODUCT");

    if (allProducts) {
      context.pushNamed(RoutesPath.mainInformation, extra: item.id);
    } else {
      _showDialog(children: children, context: context);
    }
  }

  // ─────────────────────────────────────────────────────────
  // Internal — local list return করে, global state নেই
  // ─────────────────────────────────────────────────────────
  Future<List<HomeModel>> _fetchChildren({
    required String parentId,
    required BuildContext context,
  }) async
  {
    isLoading.value = true;
    List<HomeModel> result = [];
    try {
      final response =
      await ApiClient.getData("${ApiUrl.node}?parent_id=$parentId");
      if (response.statusCode == 200) {
        final List<dynamic> list = response.body['data'] as List<dynamic>;
        result = list.map((e) => HomeModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(context, "Failed to fetch");
      }
    } catch (e) {
      CustomSnackbar.error(context, e.toString());
      debugPrint(e.toString());
    }
    isLoading.value = false;
    return result;
  }

  // ─────────────────────────────────────────────────────────
  // Dialog
  // ─────────────────────────────────────────────────────────
  void _showDialog({
    required List<HomeModel> children,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => DialogWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children.map((item) {
            return Column(
              children: [
                DialogButtonWidget(
                  title: item.title ?? 'Untitled',
                  onTap: () async {
                    Navigator.of(ctx, rootNavigator: true).pop();
                    await Future.delayed(const Duration(milliseconds: 100));
                    if (context.mounted) {
                      onDialogItemClick(item, context);
                    }
                  },
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }




  Future<void> toggleBookmark({ required String itemId,}) async {
    final item = productList.firstWhereOrNull((e) => e.id == itemId);
    if (item == null) return;

    // 🔥 আগে local toggle — fast UI response
    item.isBookmarked.toggle();

    try {
      if (item.isBookmarked.value) {

        final response = await ApiClient.postData(
          ApiUrl.addBookmark,
          {"item_id": itemId},
        );

        if (response.statusCode != 200 && response.statusCode != 201) {
          item.isBookmarked.toggle();
          debugPrint("Add bookmark failed: ${response.body}");
        }
      } else {

        final response = await ApiClient.deleteData(
          ApiUrl.removeBookmark(id: itemId),

        );

        if (response.statusCode != 200) {
          item.isBookmarked.toggle();
          debugPrint("Remove bookmark failed: ${response.body}");
        }
      }
    } catch (e) {
      item.isBookmarked.toggle();
      debugPrint("Bookmark error: $e");
    }
  }





















}