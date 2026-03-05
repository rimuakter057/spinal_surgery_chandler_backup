import 'dart:convert';
import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/cart/models/cart_model.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends  GetxController {
  ///get cart api====================================
  final RxBool isLoadingGetCart = false.obs;
  final RxList<Items> cartItems = <Items>[].obs;
  Future<void> fetchCart() async {
    isLoadingGetCart.value = true;
    final response = await ApiClient.getData(ApiUrl.cart);
    isLoadingGetCart.value = false;
    if (response.statusCode == 200) {
      final cart = CartModel.fromJson(response.body['data']);
      cartItems.assignAll(cart.items ?? []);
    }
  }

  ///get single details
  final RxBool isLoadingGetSingleDetails = false.obs;
  final Rxn<HomeModel> singleDetails = Rxn<HomeModel>(); // ✅ single object

  Future<void> fetchSingleDetails({required String itemId}) async {
    isLoadingGetSingleDetails.value = true;
    final response = await ApiClient.getData(ApiUrl.singleDetails(id: itemId));
    isLoadingGetSingleDetails.value = false;

    if (response.statusCode == 200) {
      singleDetails.value = HomeModel.fromJson(response.body['data']); // ✅ HomeModel
    }
  }







  ///add cart api====================================

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











