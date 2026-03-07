import 'dart:convert';
import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/cart/models/cart_details_model.dart';
import 'package:chandler_app/feature/cart/models/cart_model.dart';
import 'package:chandler_app/feature/cart/presentation/screens/cart_details_screen.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/feature/save/models/bookmark_model.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
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
    } else {
      debugPrint(response.statusText);
    }
  }




  ///get bookmark api==================================================

  final RxBool isLoadingBookMark = false.obs;
  final RxList<BookMarkItems> bookmarkItems = <BookMarkItems>[].obs;

  Future<void> fetchBookMark() async {
    isLoadingBookMark.value = true;
    final response = await ApiClient.getData(ApiUrl.bookmark);
    isLoadingBookMark.value = false;
    if (response.statusCode == 200) {
      final bookmark = BookMarkModel.fromJson(response.body['data']);
      bookmarkItems.assignAll(bookmark.bookMarkItems ?? <BookMarkItems>[]);
    } else {
      debugPrint(response.statusText);
    }
  }

  ///delete bookmark api==================================================

  final RxBool isLoadingDeleteBookMark = false.obs;

  Future<void> removeBookMark({
    required String itemId,
    required BuildContext context,
  }) async
  {
    isLoadingDeleteBookMark.value = true;
    final response = await ApiClient.deleteData(
      ApiUrl.removeBookmark(itemId: itemId),
    );
    isLoadingDeleteBookMark.value = false;
    if (response.statusCode == 200 || response.statusCode == 204) {
      bookmarkItems.removeWhere((item) => item.id.toString() == itemId);
      CustomSnackbar.success(context: context, message: "delete successful");
    } else {
      CustomSnackbar.error(
        context,
        response.statusText ?? 'Something went wrong',
      );
    }
  }










  ///get single details
  final RxBool isLoadingGetSingleDetails = false.obs;
  final Rxn<CartDetailsModel> singleDetails = Rxn<CartDetailsModel>();

  Future<void> fetchSingleDetails({required String itemId}) async {
    isLoadingGetSingleDetails.value = true;

    debugPrint("===== fetchSingleDetails CALLED =====");
    debugPrint("itemId: $itemId");
    debugPrint("Full URL: ${ApiUrl.singleDetails(id: itemId)}");

    final response = await ApiClient.getData(ApiUrl.singleDetails(id: itemId));

    debugPrint("statusCode: ${response.statusCode}");
    debugPrint("body: ${response.body}");

    isLoadingGetSingleDetails.value = false;

    if (response.statusCode == 200) {
      final data = response.body['data'];
      debugPrint("data from body: $data");

      if (data == null) {
        debugPrint("❌ data is NULL — API returned 200 but data is empty");
        return;
      }

      singleDetails.value = CartDetailsModel.fromJson(data);
      debugPrint("✅ singleDetails set: ${singleDetails.value?.title}");
    } else {
      debugPrint("❌ API FAILED — statusCode: ${response.statusCode}");
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
