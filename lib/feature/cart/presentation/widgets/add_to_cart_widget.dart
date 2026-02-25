import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/config/app_config.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';


import 'count_button.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    required this.title,
    required this.price,
    required this.onTapDetails,
    required this.onTapIncrement,
    required this.onTapDecrement,
    required this.image,
  });

  final String title;
  final String price;
  final VoidCallback onTapDetails;
  final VoidCallback onTapIncrement;
  final VoidCallback onTapDecrement;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///images
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.borderRadius(16),
                ),
                child: CustomImage(
                  imageSrc: image,
                  height: ResponsiveHelper.height(96),
                  width: ResponsiveHelper.width(66),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(8)),

              ///details
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveHelper.width(128),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ResponsiveHelper.spacing(12),),
                    Text(
                      "Total Files 3",
                      style: context.bodyMedium.copyWith(color: AppColors.primaryColor)
                    ),
                    SizedBox(height: ResponsiveHelper.spacing(12),),
                    GestureDetector(
                      onTap: onTapDetails,
                      child: Text(
                        "details...",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.fontSize(12),
                          fontWeight: FontWeight.w400,
                          fontFamily: AppConfig.questrial,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              AppColors.greyTextColor, // underline color
                          decorationThickness: ResponsiveHelper.height(
                            2,
                          ), // underline width
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///number count
          Column(
            children: [
              CountButton(onTap: onTapDecrement,

              title: "-",
              ),
              SizedBox(height: ResponsiveHelper.spacing(4),),
              CountButton(onTap: onTapDecrement,

                title: "1",
              ),
              SizedBox(height: ResponsiveHelper.spacing(4),),
              CountButton(onTap: onTapDecrement,

                title: "+",
              ),
            ],
          ),
        ],
      ),
    );
  }
}


