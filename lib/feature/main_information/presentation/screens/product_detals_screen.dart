import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:get/get.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/network_image/custom_network_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id, });

final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartController cartController = Get.find<CartController>();


  String _buildUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return "${ApiUrl.primaryUrl}/${path.replaceAll("\\", "/")}";
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.fetchSingleDetails(itemId: widget.id); // ✅
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      final product = cartController.singleDetails.value;
      final info = product?.productInfo;
      final bannerUrl = _buildUrl(info?.videoFileUrl);
      final brochureUrl = _buildUrl(info?.brochureFileUrl);

      return Scaffold(
        appBar: CustomAppBar(title: product?.title ?? "Product"),

        body: cartController.isLoadingGetSingleDetails.value
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
          padding: ResponsiveHelper.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(15),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: bannerUrl,
                      height: ResponsiveHelper.height(200),
                      width: double.infinity,
                    ),
                  ),
                  CustomImage(imageSrc: AppAssets.play),
                ],
              ),

              SizedBox(height: ResponsiveHelper.spacing(20)),

              /// Title + Brochure download
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product?.title ?? "",
                      style: context.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (brochureUrl.isNotEmpty)
                    GestureDetector(
                      onTap: () {

                      },
                      child: Row(
                        children: [
                          CustomImage(imageSrc: AppAssets.downloadImage),
                          SizedBox(width: ResponsiveHelper.width(6)),
                          Text(
                            'Download',
                            style: context.bodyMedium.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                          ),
                          SizedBox(width: ResponsiveHelper.width(6)),
                          CustomImage(imageSrc: AppAssets.download),
                        ],
                      ),
                    ),
                ],
              ),

              SizedBox(height: ResponsiveHelper.height(20)),

              /// Description
              Text(
                info?.description ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.blackTextColor,
                ),
              ),

              SizedBox(height: ResponsiveHelper.spacing(24)),
            ],
          ),
        ),

        // /// Bottom Add to Cart button
        // bottomNavigationBar: Padding(
        //   padding: ResponsiveHelper.symmetric(horizontal: 20.0, vertical: 20.0),
        //   child: ElevatedButton(
        //     onPressed: cartController.isLoading.value
        //         ? null
        //         : () async {
        //       if (product == null) return;
        //       final success = await cartController.addToCart(
        //         product: product,
        //         context: context,
        //       );
        //       if (success) {
        //         CustomSnackbar.success(context, "Added to cart!");
        //       } else {
        //         CustomSnackbar.error(context, "Failed to add to cart");
        //       }
        //     },
        //     child: cartController.isLoading.value
        //         ? const CustomLoader()
        //         : Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         CustomImage(imageSrc: AppAssets.cartWhite),
        //         SizedBox(width: ResponsiveHelper.width(8)),
        //         Text(AppText.addToCart),
        //       ],
        //     ),
        //   ),
        // ),
      );
    });
  }


}
