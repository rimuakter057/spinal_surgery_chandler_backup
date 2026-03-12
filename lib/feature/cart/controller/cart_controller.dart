import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/cart/models/cart_details_model.dart';
import 'package:chandler_app/feature/cart/models/cart_model.dart';
import 'package:chandler_app/feature/history/model/history_model.dart' hide Items;
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/feature/save/models/bookmark_model.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {


///fetch cart list====================================================

  final RxBool isLoadingGetCart = false.obs;
  final RxList<Items> cartItems = <Items>[].obs;
  final RxMap<String, int> itemQuantities = <String, int>{}.obs;

  Future<void> fetchCart() async {
    isLoadingGetCart.value = true;
    final response = await ApiClient.getData(ApiUrl.cart);
    isLoadingGetCart.value = false;
    if (response.statusCode == 200) {
      final cart = CartModel.fromJson(response.body['data']);
      cartItems.assignAll(cart.items ?? []);

      for (var item in cart.items ?? []) {
        itemQuantities[item.id ?? ""] = item.quantity ?? 1; // ✅ item.id
      }
    } else {
      debugPrint(response.statusText);
    }
  }

  ///fetch increment count====================================================

  Future<void> incrementItem({required String id,required BuildContext context}) async {
    debugPrint("incrementItem called ====== id: $id"); // ✅
    debugPrint("itemQuantities before ===== ${itemQuantities}"); // ✅

    final current = itemQuantities[id] ?? 1;
    debugPrint("current quantity ========== $current"); // ✅

    itemQuantities[id] = current + 1;
    debugPrint("itemQuantities after ====== ${itemQuantities}"); // ✅

    final response = await ApiClient.patchData(
      ApiUrl.updateItemQuantity(itemId: id),
      {"quantity": itemQuantities[id]},
    );

    debugPrint("response status =========== ${response.statusCode}"); // ✅
    debugPrint("response body ============= ${response.body}"); // ✅

    if (response.statusCode != 200) {
      itemQuantities[id] = current;
      debugPrint(response.statusText);
    }
    else if(response.statusCode==429){
      CustomSnackbar.error(context, "To many request");
    }
  }

  ///fetch decrement count====================================================

  Future<void> decrementItem({required String id,required BuildContext context}) async {
    final current = itemQuantities[id] ?? 1;
    if (current <= 1) return;

    itemQuantities[id] = current - 1;

    final response = await ApiClient.patchData(
      ApiUrl.updateItemQuantity(itemId: id), // ✅ item.id
      {"quantity": itemQuantities[id]},
    );

    if (response.statusCode != 200) {
      itemQuantities[id] = current;
      debugPrint(response.statusText);
    }  else if(response.statusCode==429){
      CustomSnackbar.error(context, "To many request");
    }
  }



  /// place order api====================================
  final RxBool isLoadingOrder = false.obs;

  Future<bool> placeOrder({
    required String shippingAddress,
    required String deliveryDate,
    required String notes,
  }) async {
    isLoadingOrder.value = true;

    debugPrint("=== cartItems count: ${cartItems.length}");

    for (var item in cartItems) {
      debugPrint("=== item: ${item.itemTitle} | qty: ${item.quantity}");
    }

    // 🔥 cartItems থেকে items list বানাও
    final List<Map<String, dynamic>> itemsList = cartItems
        .map(
          (item) => {
            "product_id": item.itemId,
            "product_title": item.itemTitle,
            "product_image": item.itemImage,
            "quantity": item.quantity ?? 1,
          },
        )
        .toList();

    final body = {
      "items": itemsList,
      "shipping_address": shippingAddress,
      "delivery_date": deliveryDate,
      "notes": notes,
    };

    final response = await ApiClient.postData(ApiUrl.orders, body);
    isLoadingOrder.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      debugPrint(response.statusText);
      return false;
    }
  }

  // ///get bookmark api==================================================
  //
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

  final RxString deletingItemId = ''.obs; // কোন item delete হচ্ছে track করবে

  Future<void> removeBookMark({
    required String itemId,
    required BuildContext context,
  }) async {
    deletingItemId.value = itemId; // শুধু এই item এর loader

    final response = await ApiClient.deleteData(
      ApiUrl.removeBookmark(id: itemId),
    );

    deletingItemId.value = '';

    debugPrint("Trying to delete itemId: $itemId");
    debugPrint(
      "bookmarkItems itemIds: ${bookmarkItems.map((e) => e.itemId).toList()}",
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      bookmarkItems.removeWhere((item) => item.itemId.toString() == itemId);

      CustomSnackbar.success(context: context, message: "Delete successful");
    } else {
      CustomSnackbar.error(
        context,
        response.statusText ?? 'Something went wrong',
      );
    }
  }

  ///get single details=============================================
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


  /// get order history api ====================================
  final RxBool isLoadingHistory = false.obs;       // প্রথম পেজ loader
  final RxBool isLoadingMoreHistory = false.obs;   // ✅ scroll pagination loader
  final RxList<Orders> orderHistory = <Orders>[].obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final int historyLimit = 8;

  Future<void> fetchOrderHistory({int page = 1}) async {
    // duplicate call বন্ধ করো
    if (isLoadingHistory.value || isLoadingMoreHistory.value) return;
    if (page > totalPages.value && page != 1) return;

    // ✅ page 1 = full loader | page 2+ = linear indicator
    if (page == 1) {
      isLoadingHistory.value = true;
    } else {
      isLoadingMoreHistory.value = true;
    }

    final response = await ApiClient.getData(
      ApiUrl.getAllHistory(page: page, limit: historyLimit),
    );

    // দুইটাই false করো
    isLoadingHistory.value = false;
    isLoadingMoreHistory.value = false;

    if (response.statusCode == 200) {
      final historyModel = HistoryModel.fromJson(response.body['data']);

      final int total = historyModel.totalOrders ?? 0;
      totalPages.value = (total / historyLimit).ceil();

      if (page == 1) orderHistory.clear();
      orderHistory.addAll(historyModel.orders ?? []);
      currentPage.value = page;

      debugPrint("✅ Page: $page / ${totalPages.value} | Total: $total");
    } else {
      debugPrint("❌ History fetch failed: ${response.statusText}");
    }
  }





}
