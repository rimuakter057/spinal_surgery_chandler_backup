
import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/save/presentation/widgets/delete_confirmation_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:chandler_app/share/widgets/network_image/custom_network_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final CartController controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    controller.fetchBookMark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("Saved Product", style: context.titleSmall),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchBookMark();
        },
        child: Obx(() {
          if (controller.isLoadingBookMark.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.bookmarkItems.isEmpty) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Center(
                      child: Text(
                        "No saved products",
                        style: context.bodyMedium,
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: ResponsiveHelper.all(8),
            itemCount: controller.bookmarkItems.length,
            itemBuilder: (context, index) {
              final item = controller.bookmarkItems[index];

              return Padding(
                padding: EdgeInsets.only(bottom: ResponsiveHelper.spacing(8)),
                child: CustomContainer(
                  backgroundColor: AppColors.primaryShadeColor,
                  child: Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(16),
                        ),
                        child: item.item?.productInfo?.bannerImageUrl != null
                            ? CustomNetworkImage(
                          height: ResponsiveHelper.iconSize(88),
                          width: ResponsiveHelper.iconSize(126),
                          imageUrl: item.item!.productInfo!.bannerImageUrl!,
                        )
                            : CustomImage(
                          imageSrc: AppAssets.doctorImage,
                          height: ResponsiveHelper.iconSize(88),
                          width: ResponsiveHelper.iconSize(126),
                        ),
                      ),

                      SizedBox(width: ResponsiveHelper.width(16)),

                      // Title & details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.item?.title ?? 'N/A',
                              style: context.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: ResponsiveHelper.spacing(8)),
                            Text("details..."),
                          ],
                        ),
                      ),

                      SizedBox(width: ResponsiveHelper.width(8)),

                      // Delete button
                      IconButton(
                        onPressed: () {
                          DeleteConfirmationDialog.show(
                            context: context,
                            onConfirm: () => controller.removeBookMark(
                              itemId: item.itemId.toString(),
                              context: context,
                            ),
                          );
                        },
                        icon: Obx(
                              () => controller.deletingItemId.value == item.itemId.toString()
                              ? CustomLoader()
                              : Icon(
                            Icons.delete,
                            size: ResponsiveHelper.iconSize(24),
                            color: AppColors.red,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}