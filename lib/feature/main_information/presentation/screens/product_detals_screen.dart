import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/helper/download-helper_file/download_helper.dart';
import 'package:chandler_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
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
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final title = cartController.singleDetails.value?.title ?? "Product";
          return CustomAppBar(title: title);
        }),
      ),

      body: Obx(() {
        final isLoading = cartController.isLoadingGetSingleDetails.value;

        if (isLoading) {
          return const Center(child: CustomLoader());
        }

        final product = cartController.singleDetails.value;
        final info = product?.productInfo;
        final videoUrl = _buildUrl(info?.videoFileUrl);
        final brochureUrl = _buildUrl(info?.brochureFileUrl);

        // ✅ Debug prints
        debugPrint("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
        debugPrint("📦 product:===================== $product");
        debugPrint("ℹ️  info:================= $info");
        debugPrint("🎥 videoUrl:================= $videoUrl");
        debugPrint("📄 brochureUrl:==================== $brochureUrl");
        debugPrint("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

        return SingleChildScrollView(
          padding: ResponsiveHelper.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Thumbnail
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(15),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: videoUrl,
                      height: ResponsiveHelper.height(200),
                      width: double.infinity,
                    ),
                  ),
                  CustomImage(imageSrc: AppAssets.play),
                ],
              ),

              SizedBox(height: ResponsiveHelper.spacing(20)),


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
                ],
              ),

              SizedBox(height: ResponsiveHelper.height(20)),

              // PDF Viewer
              if (brochureUrl.isNotEmpty)
                SizedBox(
                  height: ResponsiveHelper.height(300),
                  width: double.infinity,
                  child: SfPdfViewer.network(brochureUrl),
                ),

              SizedBox(height: ResponsiveHelper.spacing(24)),
            ],
          ),
        );
      }),

      bottomNavigationBar: Padding(
        padding: ResponsiveHelper.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Obx(() {
          final isCartLoading = homeController.isLoadingCart.value;
          final product = cartController.singleDetails.value;

          return ElevatedButton(
            onPressed: isCartLoading
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
                      CustomSnackbar.error(context, "Failed to add to cart");
                    }
                  },
            child: isCartLoading
                ? const CustomLoader()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImage(imageSrc: AppAssets.cartWhite),
                      SizedBox(width: ResponsiveHelper.width(8)),
                      Text(AppText.addToCart),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}

//
// Future<void> _downloadBrochure({
//   required String url,
//   required BuildContext context,
// }) async
// {
//   try {
//    // CustomSnackbar.success(context: context, message: "Downloading...");
//
//     final dio = Dio();
//     final fileName = url.split('/').last.split('?').first;
//
//     Directory? dir;
//     if (Platform.isAndroid) {
//       dir = Directory('/storage/emulated/0/Download');
//       if (!await dir.exists()) {
//         dir = await getExternalStorageDirectory();
//       }
//     } else {
//       dir = await getApplicationDocumentsDirectory();
//     }
//
//     final savePath = "${dir!.path}/$fileName";
//
//     await dio.download(
//       url,
//       savePath,
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           debugPrint("Progress: ${(received / total * 100).toStringAsFixed(0)}%");
//         }
//       },
//     );
//
//     // ✅ Media Scanner — file টা Gallery/Files app এ visible করে
//     await Process.run('am', [
//       'broadcast',
//       '-a', 'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
//       '-d', 'file://$savePath',
//     ]);
//
//     debugPrint("Saved to: $savePath");
//
//     CustomSnackbar.success(
//       context: context,
//       message: "Saved to Downloads/$fileName",
//     );
//   } catch (e) {
//     debugPrint("Download error: $e");
//     CustomSnackbar.error(context, "Download failed");
//   }
// }
