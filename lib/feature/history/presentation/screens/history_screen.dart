
// import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
// import 'package:chandler_app/feature/history/model/history_model.dart';
// import 'package:chandler_app/feature/history/presentation/widgets/order_card.dart';
// import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
// import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
// import 'package:chandler_app/utils/app_assets/app_assets.dart';
// import 'package:chandler_app/utils/color/app_colors.dart';
// import 'package:chandler_app/utils/extension/base_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({super.key});
//
//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }
//
// class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final CartController cartController = Get.find<CartController>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     cartController.fetchOrderHistory(page: 1);
//     _scrollController.addListener(_onScroll);
//
//     // ✅ orderHistory list যতবার change হবে — check করো স্ক্রিন ভরাট হয়েছে কিনা
//     ever(cartController.orderHistory, (_) {
//       Future.delayed(const Duration(milliseconds: 300), _checkIfNeedMoreData);
//     });
//   }
//
//   /// স্ক্রিন ভরাট না হলে পরের পেজ লোড করো
//   void _checkIfNeedMoreData() {
//     if (!_scrollController.hasClients) return;
//
//     final bool contentFitsScreen =
//         _scrollController.position.maxScrollExtent == 0;
//
//     final bool canLoadMore =
//         !cartController.isLoadingHistory.value &&
//             cartController.currentPage.value < cartController.totalPages.value;
//
//     debugPrint(
//       "📏 maxScrollExtent: ${_scrollController.position.maxScrollExtent} | canLoadMore: $canLoadMore",
//     );
//
//     if (contentFitsScreen && canLoadMore) {
//       cartController.fetchOrderHistory(
//         page: cartController.currentPage.value + 1,
//       );
//     }
//   }
//
//   void _onScroll() {
//     final isNearBottom = _scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200;
//
//     final bool canLoadMore =
//         !cartController.isLoadingHistory.value &&
//             cartController.currentPage.value < cartController.totalPages.value;
//
//     if (isNearBottom && canLoadMore) {
//       cartController.fetchOrderHistory(
//         page: cartController.currentPage.value + 1,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }
//
//
//
//
//
//
//
//   Color _getStatusColor(String? status) {
//     switch ((status ?? '').toLowerCase()) {
//       case 'completed':
//         return AppColors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: CustomAppBar(title: "History"),
//       body: Padding(
//         padding: ResponsiveHelper.all(16),
//         child: Column(
//           children: [
//             /// Search Bar
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: "Search here...",
//                 hintStyle: context.bodyMedium.copyWith(
//                   color: AppColors.searchTextColor,
//                 ),
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.only(
//                     left: ResponsiveHelper.padding(16),
//                   ),
//                   child: CustomImage(
//                     imageSrc: AppAssets.search,
//                     height: ResponsiveHelper.iconSize(18),
//                     width: ResponsiveHelper.iconSize(18),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: ResponsiveHelper.spacing(16)),
//
//             /// Order List
//             Expanded(
//               child: Obx(() {
//                 /// Initial loading
//                 if (cartController.isLoadingHistory.value &&
//                     cartController.orderHistory.isEmpty) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 /// Empty state
//                 if (cartController.orderHistory.isEmpty) {
//                   return const Center(child: Text("No order history found."));
//                 }
//
//                 final bool showBottomLoader =
//                     cartController.isLoadingHistory.value &&
//                         cartController.orderHistory.isNotEmpty;
//
//                 return ListView.separated(
//                   controller: _scrollController,
//                   // +1 for bottom loader
//                   itemCount: cartController.orderHistory.length +
//                       (showBottomLoader ? 1 : 0),
//                   separatorBuilder: (_, __) =>
//                       SizedBox(height: ResponsiveHelper.spacing(12)),
//                   itemBuilder: (context, index) {
//                     /// Bottom pagination loader
//                     if (index == cartController.orderHistory.length) {
//                       return const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     }
//
//                     final Orders order = cartController.orderHistory[index];
//
//                     return OrderCardWidget(
//                       orderId: order.id ?? '#000',
//                       totalItem: (order.items?.length ?? 0).toString(),
//                       totalPrice: '0', // map from your model if available
//                       date: order.deliveryDate ?? '',
//                       status: order.orderStatus ?? 'Complete',
//                       statusBgColor: _getStatusColor(order.orderStatus),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/history/model/history_model.dart';
import 'package:chandler_app/feature/history/presentation/widgets/order_card.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final CartController cartController = Get.find<CartController>();
  Worker? _everWorker;

  @override
  void initState() {
    super.initState();

    cartController.fetchOrderHistory(page: 1);
    _scrollController.addListener(_onScroll);

    _everWorker = ever(cartController.orderHistory, (_) {
      Future.delayed(
        const Duration(milliseconds: 300),
        _checkIfNeedMoreData,
      );
    });
  }

  void _checkIfNeedMoreData() {
    if (!_scrollController.hasClients) return;

    final bool contentFitsScreen =
        _scrollController.position.maxScrollExtent == 0;

    final bool canLoadMore = !cartController.isLoadingHistory.value &&
        !cartController.isLoadingMoreHistory.value &&
        cartController.currentPage.value < cartController.totalPages.value;

    if (contentFitsScreen && canLoadMore) {
      cartController.fetchOrderHistory(
        page: cartController.currentPage.value + 1,
      );
    }
  }

  void _onScroll() {
    final isNearBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    final bool canLoadMore = !cartController.isLoadingHistory.value &&
        !cartController.isLoadingMoreHistory.value &&
        cartController.currentPage.value < cartController.totalPages.value;

    if (isNearBottom && canLoadMore) {
      cartController.fetchOrderHistory(
        page: cartController.currentPage.value + 1,
      );
    }
  }

  @override
  void dispose() {
    _everWorker?.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'completed':
        return AppColors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(title: "History"),
      body: Stack(
        children: [
          /// ── Main Content ──
          Padding(
            padding: ResponsiveHelper.all(16),
            child: Column(
              children: [
                /// Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search here...",
                    hintStyle: context.bodyMedium.copyWith(
                      color: AppColors.searchTextColor,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveHelper.padding(16),
                      ),
                      child: CustomImage(
                        imageSrc: AppAssets.search,
                        height: ResponsiveHelper.iconSize(18),
                        width: ResponsiveHelper.iconSize(18),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.spacing(16)),

                /// Order List
                Expanded(
                  child: Obx(() {
                    /// Initial loading
                    if (cartController.isLoadingHistory.value &&
                        cartController.orderHistory.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    /// Empty state
                    if (cartController.orderHistory.isEmpty) {
                      return const Center(
                        child: Text("No order history found."),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await cartController.fetchOrderHistory(page: 1);
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: cartController.orderHistory.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: ResponsiveHelper.spacing(12)),
                        itemBuilder: (context, index) {
                          final Orders order = cartController.orderHistory[index];
                          return OrderCardWidget(
                            orderId: order.id ?? '#000',
                            totalItem: (order.items?.length ?? 0).toString(),
                            totalPrice: '0',
                            date: order.deliveryDate ?? '',
                            status: order.orderStatus ?? 'Pending',
                            statusBgColor: _getStatusColor(order.orderStatus),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          /// ✅ Screen এর একদম নিচে — smooth linear indicator
          Obx(
                () => AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 350),
                opacity: cartController.isLoadingMoreHistory.value ? 1.0 : 0.0,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.primaryColor,
                  minHeight: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}