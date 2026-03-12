import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/add_to_cart_widget.dart';
import 'package:chandler_app/helper/image_handler/image_handler.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final CartController controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),

      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Posterior Cervical Fixation",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveHelper.padding(12)),
            child:    GestureDetector(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: CustomImage(imageSrc: AppAssets.menu),
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async => await controller.fetchCart(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: ResponsiveHelper.all(16),
              child: Obx(() {

                // ✅ loading
                if (controller.isLoadingGetCart.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ✅ reactive list
                final items = controller.cartItems;

                return Column(
                  children: [

                    /// Search Bar
                    TextField(
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

                    SizedBox(height: ResponsiveHelper.height(12)),

                    /// Empty State
                    if (items.isEmpty) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveHelper.spacing(60),
                        ),
                        child: const Center(child: Text("Cart is empty")),
                      ),
                    ] else ...[

                      /// Cart List
                      ListView.separated(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: ResponsiveHelper.height(8)),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Obx(() => AddToCartWidget( // ✅ Obx
                            title: item.itemTitle ?? "",
                            price: (controller.itemQuantities[item.id ?? ""] ?? 1).toString(), // ✅ itemQuantities
                            image: ImageHandler.imagesHandle(item.itemImage),
                            onTapDetails: () {
                              context.pushNamed(
                                RoutesPath.productDetailsScreen,
                                extra: item.itemId,
                              );
                            },
                            onTapIncrement: () {
                              debugPrint("item.id ================= ${item.id}"); // ✅ id check
                              debugPrint("itemQuantities ========= ${controller.itemQuantities}"); // ✅ map check
                              controller.incrementItem(id:item.id ?? "",context: context);
                            },// ✅
                            onTapDecrement: () {
                              debugPrint("on tap decrement===============================");
                              controller.decrementItem(id:item.id ?? "",context: context);}, // ✅
                            countText: controller.itemQuantities[item.id ?? ""] ?? 1, // ✅
                          ));
                        },
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      /// Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Product:", style: context.bodyMedium),
                          Text(
                            "${items.length}",
                            style: context.bodyLarge.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: ResponsiveHelper.height(48)),

                      /// Order Button
                      ElevatedButton(
                        child: Text(AppText.order),
                        onPressed: () {
                          context.pushNamed(RoutesPath.orderScreen);
                        },
                      ),

                      SizedBox(height: ResponsiveHelper.height(100)),
                    ],
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}