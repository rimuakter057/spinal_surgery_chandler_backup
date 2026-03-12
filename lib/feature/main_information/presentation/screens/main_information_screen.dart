import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../share/widgets/custom_loader/custom_loader.dart';

class MainInformationScreen extends StatefulWidget {
  const MainInformationScreen({super.key, required this.parentId, required this.title,});

  final String parentId;
final String title;


  @override
  State<MainInformationScreen> createState() => _MainInformationScreenState();
}

class _MainInformationScreenState extends State<MainInformationScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController controller = Get.find<HomeController>();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProducts(
          parentId: widget.parentId,

          context: context);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await controller.fetchProducts(parentId: widget.parentId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomImage(
            imageSrc: AppAssets.back,
            height: ResponsiveHelper.height(24),
            width: ResponsiveHelper.width(24),
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
         widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveHelper.padding(12)),
            child:   GestureDetector(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: CustomImage(imageSrc: AppAssets.menu),
            ),
          ),
        ],
      ),
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(child: CustomLoader()),
                    );
                  }

                  final filtered = searchQuery.value.isEmpty
                      ? controller.productList.toList()
                      : controller.productList
                      .where(
                        (e) => (e.title ?? '').toLowerCase().contains(
                      searchQuery.value,
                    ),
                  )
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
                      childAspectRatio: 0.88,
                    ),





                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        final isProduct = item.type?.toUpperCase() == "PRODUCT";

                        // Non-PRODUCT → simple title container
                        if (!isProduct) {
                          return GestureDetector(
                            onTap: () {
                              debugPrint("=== shoreline parentId: ${item.id}");
                              context.pushNamed(RoutesPath.shoreLine,
                                  extra: {
                                    'parentId': item.id,
                                    'title': item.title ?? "",
                                  }
                              );



                            },


                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),

                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                item.title ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: context.titleMedium.copyWith(color: AppColors.white),
                              ),
                            ),
                          );
                        }

                        // PRODUCT → existing ProductCard
                        final imageUrl =
                            "${ApiUrl.primaryUrl}/${item.productInfo?.bannerImageUrl?.replaceAll("\\", "/")}";

                        return ProductCard(
                          isBookmarked: item.isBookmarked,
                          imageUrl: imageUrl,
                          title: item.title ?? "",
                          onAddToCart: () async {
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
                            debugPrint("=== id: ${item.id}");
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