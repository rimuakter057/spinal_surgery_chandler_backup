

import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends  GetxController {
  final RxBool isLoading = false.obs;

  Future<bool> addToCart({
    required HomeModel product,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    final body = {
      "item_id": product.id,
      "item_title": product.title,
      "item_image": product.productInfo?.bannerImageUrl, // raw path
      "quantity": 1,
    };

    final response = await ApiClient.postData(ApiUrl.addToCart, body);
    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  }











