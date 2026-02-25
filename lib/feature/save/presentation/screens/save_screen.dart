import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/network_image/custom_network_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/config/app_config.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final List<Map<String, String>> savedList = [
    {"title": "Posterior Cervical Fixation", "files": "Total Files 3"},
    {"title": "Lumbar Spine Fixation", "files": "Total Files 5"},
    {"title": "Thoracic Fixation", "files": "Total Files 2"},
    {"title": "Spine Surgery Guide", "files": "Total Files 4"},
    {"title": "Posterior Cervical Fixation", "files": "Total Files 3"},
    {"title": "Lumbar Spine Fixation", "files": "Total Files 5"},
    {"title": "Thoracic Fixation", "files": "Total Files 2"},
    {"title": "Spine Surgery Guide", "files": "Total Files 4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text("Saved Product", style: context.titleSmall)),

      body: ListView.builder(
        padding: ResponsiveHelper.all(8),

        itemCount: savedList.length + 1,

        itemBuilder: (context, index) {
          /// ✅ Last button
          if (index == savedList.length) {
            return Padding(
              padding: EdgeInsets.only(
                top: ResponsiveHelper.padding(12),
                left: ResponsiveHelper.padding(12),
                right: ResponsiveHelper.padding(12),
                bottom: ResponsiveHelper.padding(100),
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Save Product"),
              ),
            );
          }

          /// normal item
          final item = savedList[index];

          return Padding(
            padding: EdgeInsets.only(bottom: ResponsiveHelper.spacing(8)),
            child: CustomContainer(
              backgroundColor: AppColors.primaryShadeColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(16),
                        ),
                        child: CustomImage(
                          imageSrc: AppAssets.doctorImage,
                          height: ResponsiveHelper.iconSize(88),
                          width: ResponsiveHelper.iconSize(126),
                        ),

                        // child: CustomNetworkImage(
                        //   height: ResponsiveHelper.iconSize(88),
                        //   width: ResponsiveHelper.iconSize(106),
                        //   imageUrl: AppConstant.unknown,
                        // ),
                      ),

                      SizedBox(width: ResponsiveHelper.width(16)),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ResponsiveHelper.width(180),
                            child: Text(
                              item["title"]!,
                              style: context.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(height: ResponsiveHelper.spacing(8)),

                          Text(item["files"]!, style: context.bodyMedium),

                          SizedBox(height: ResponsiveHelper.spacing(8)),

                          Text("Add to cart"),

                          SizedBox(height: ResponsiveHelper.spacing(8)),

                          Text("details..."),
                        ],
                      ),
                    ],
                  ),

                  CustomImage(imageSrc: AppAssets.save),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ///search bar=============================
// TextField(
// decoration: InputDecoration(
// hintText: "Search here...",
// hintStyle: context.bodyMedium.copyWith(
// color: AppColors.searchTextColor,
// ),
//
//
// ),
// ),
//
// ProductCard(imageUrl: AppConstant.unknown,
// title: 'Reform POCT',
// onAddToCart: () {  },
// onBookmark: () {  },
// onInfo: () {  },),
