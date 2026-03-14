import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ShorelineScreen extends StatefulWidget {
  const ShorelineScreen({super.key, required this.parentId, required this.title});

  final String parentId;
  final String title;

  @override
  State<ShorelineScreen> createState() => _ShorelineScreenState();
}

class _ShorelineScreenState extends State<ShorelineScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController controller = Get.find<HomeController>();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;


  // initState
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchShorelineProducts(  // ← পরিবর্তন
        parentId: widget.parentId,
        context: context,
      );
    });
  }

// _onRefresh
  Future<void> _onRefresh() async {
    await controller.fetchShorelineProducts(  // ← পরিবর্তন
      parentId: widget.parentId,
      context: context,
    );
  }







  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     controller.fetchProducts(parentId: widget.parentId, context: context);
  //   });
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Future<void> _onRefresh() async {
  //   await controller.fetchProducts(parentId: widget.parentId, context: context);
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint("Shore line  parentId: ===============================${widget.parentId}");
    debugPrint("shore line title==========================: ${widget.title}");
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),
      appBar: CustomAppBar(title: widget.title),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: ResponsiveHelper.all(8.0),
            child: Column(
              children: [
                /// Search Bar
                TextField(
                  controller: searchController,
                  onChanged: (val) => searchQuery.value = val.toLowerCase(),
                  decoration: InputDecoration(
                    hintText: "Search here...",
                    hintStyle: context.bodyMedium.copyWith(
                      color: AppColors.searchTextColor,
                    ),
                prefixIcon: Padding(
                  padding:  EdgeInsets.only(left: ResponsiveHelper.width(8)),
            child: CustomImage(imageSrc: AppAssets.search),
          ),
                    suffixIcon: Obx(
                          () => searchQuery.value.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchQuery.value = '';
                        },
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.spacing(12)),

                /// Product Grid
                // Obx(() {
                //   if (controller.isLoading.value) {
                //     return const Padding(
                //       padding: EdgeInsets.only(top: 60),
                //       child: Center(child: CustomLoader()),
                //     );
                //   }
                //
                //   final filtered = searchQuery.value.isEmpty
                //       ? controller.productList.toList()
                //       : controller.productList
                //       .where(
                //         (e) => (e.title ?? '').toLowerCase().contains(
                //       searchQuery.value,
                //     ),
                //   )
                //       .toList();




                Obx(() {
                  if (controller.isLoadingShoreline.value) {  // ← পরিবর্তন
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(child: CustomLoader()),
                    );
                  }

                  final filtered = searchQuery.value.isEmpty
                      ? controller.shorelineList.toList()  // ← পরিবর্তন
                      : controller.shorelineList           // ← পরিবর্তন
                      .where((e) => (e.title ?? '').toLowerCase()
                      .contains(searchQuery.value))
                      .toList();




                  if (filtered.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(child: Text("No Products Found")),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ResponsiveHelper.spacing(12),
                      mainAxisSpacing: ResponsiveHelper.spacing(12),
                      childAspectRatio: 0.9,
                    ),



                    itemBuilder: (context, index) {
                      final item = filtered[index];


                      final bannerUrl = item.productInfo?.bannerImageUrl;
                      final imageUrl = bannerUrl != null
                          ? "${ApiUrl.primaryUrl}/${bannerUrl.replaceAll("\\", "/")}"
                          : "";
                      return ProductCard(
                        isBookmarked: item.isBookmarked,
                        imageUrl: imageUrl, // empty হলে ProductCard এ handle করো
                        title: item.title ?? "",
                        onAddToCart: () async {
                          debugPrint("add cart parentId============================: ${item.id}");
                          debugPrint("add title title=============================: ${item.title}");
                          final success = await controller.addToCart(
                            itemId: item.id ?? "",
                            itemTitle: item.title ?? "",
                            itemImage: item.productInfo?.bannerImageUrl ?? "",
                          );
                          if (success) {
                            CustomSnackbar.success(context: context, message: "Added to cart!");
                          } else {
                            CustomSnackbar.error(context, "Failed to add to cart");
                          }
                        },
                        tapDetails: () {
                          debugPrint("=== before on tap navigate shoreline============================= ${item.id}");
                          context.pushNamed(RoutesPath.productDetailsScreen,
                              extra: {
                                "id": item.id,
                                "title": item.title,
                              }
                          );
                        },
                        onBookmark: () async {
                          controller.toggleBookmark(itemId: item.id.toString());
                        },
                        onInfo: () {},
                      );
                    },




                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}