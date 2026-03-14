import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/helper/download-helper_file/download_helper.dart';
import 'package:chandler_app/helper/pdf_viewer/pdf_helper.dart';
import 'package:chandler_app/helper/video_helper/video_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/network_image/custom_network_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id, required this.title});

  final String id;
final String title;


  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();

  ///  VideoHelper — সব video logic এখানে
  final VideoHelper _videoHelper = VideoHelper();

  String _buildUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return "${ApiUrl.primaryUrl}/${path.replaceAll("\\", "/")}";
  }

  @override
  void initState() {
    super.initState();
    cartController.singleDetails.value = null;
    cartController.fetchSingleDetails(itemId: widget.id);
  }

  @override
  void dispose() {
    _videoHelper.dispose(); ///  একটা line এ সব dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    debugPrint("product details parentId=======================: ${widget.id}");
    debugPrint("product details title==========================: ${widget.title}");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final title = cartController.singleDetails.value?.title ?? "Product";
          return CustomAppBar(title: widget.title);
        }),
      ),

      body: Obx(() {
        final isLoading = cartController.isLoadingGetSingleDetails.value;
        if (isLoading) return const Center(child: CustomLoader());

        final product = cartController.singleDetails.value;
        final info = product?.productInfo;
        final videoUrl = _buildUrl(info?.videoFileUrl);
        final brochureUrl = _buildUrl(info?.brochureFileUrl);
        final bannerUrl = _buildUrl(info?.bannerImageUrl);

        return SingleChildScrollView(
          padding: ResponsiveHelper.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ Video Section
              AspectRatio(
                aspectRatio: _videoHelper.isVideoInitialized
                    ? _videoHelper.videoController!.value.aspectRatio
                    : 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadius(15),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Banner image
                      Positioned.fill(
                        child: CustomNetworkImage(
                          imageUrl: bannerUrl,
                          width: double.infinity,
                        ),
                      ),

                      // Video player
                      if (_videoHelper.isVideoInitialized)
                        Positioned.fill(
                          child: Chewie(
                            controller: _videoHelper.chewieController!,
                          ),
                        ),

                      // Loading spinner
                      if (_videoHelper.isVideoLoading)
                        Container(
                          color: Colors.black45,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          ),
                        ),

                      // Play button
                      if (!_videoHelper.isVideoInitialized &&
                          !_videoHelper.isVideoLoading)
                        GestureDetector(
                          onTap: () => _videoHelper.initVideo(
                            videoUrl: videoUrl,
                            onStateChanged: () =>
                                setState(() {}), // ✅ UI update
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: CustomImage(imageSrc: AppAssets.play),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(20)),

              /// ✅ PDF Viewer
              if (brochureUrl.isNotEmpty)
                PdfHelper.buildPdfViewer(
                  pdfUrl: brochureUrl,
                  //heightFactor: 0.6,
                ),
              SizedBox(height: ResponsiveHelper.spacing(20)),

              /// ✅ Download + Add to Cart Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Download
                  if (brochureUrl.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        final success = await DownloadHelper.downloadFile(
                          url: brochureUrl,
                          context: context,
                        );
                        if (success) {
                          CustomSnackbar.success(
                            context: context,
                            message: "Downloaded!",
                          );
                        } else {
                          CustomSnackbar.error(context, "Download failed");
                        }
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

                  // Add to Cart
                  Obx(() {
                    final isCartLoading = homeController.isLoadingCart.value;
                    final product = cartController.singleDetails.value;

                    return GestureDetector(
                      onTap: isCartLoading
                          ? null
                          : () async {
                              if (product == null) return;
                              final bannerUrl = _buildUrl(
                                product.productInfo?.bannerImageUrl,
                              );
                              final success = await homeController.addToCart(
                                itemId: widget.id,
                                itemTitle: product.title ?? "",
                                itemImage: bannerUrl,
                              );
                              if (success) {
                                CustomSnackbar.success(
                                  context: context,
                                  message: "Added to cart!",
                                );
                              } else {
                                CustomSnackbar.error(
                                  context,
                                  "Failed to add to cart",
                                );
                              }
                            },
                      child: isCartLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : CustomContainer(
                              backgroundColor: AppColors.primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomImage(imageSrc: AppAssets.cartWhite),
                                  SizedBox(width: ResponsiveHelper.width(8)),
                                  Text(
                                    AppText.addToCart,
                                    style: context.bodyMedium.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
