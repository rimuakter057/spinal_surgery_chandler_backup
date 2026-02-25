import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onAddToCart;
  final VoidCallback onBookmark;
  final VoidCallback onInfo;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAddToCart,
    required this.onBookmark,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.height(164),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),

      ),
      padding:  ResponsiveHelper.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Info Icon
          GestureDetector(
            onTap: (){

           context.pushNamed(RoutesPath.addCartScreen);

            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  
                  child: CustomImage(imageSrc: AppAssets.doctorImage),

                  // child: Image.network(
                  //   imageUrl,
                  //   height: ResponsiveHelper.height(96),
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onInfo,
                    child: Container(
                      padding:  ResponsiveHelper.all(6),
                      decoration: BoxDecoration(
                       // color: Colors.black.withOpacity(0.3),
                        color: AppColors.blackShade,
                        shape: BoxShape.circle,
                      ),
                      child: CustomImage(imageSrc: AppAssets.info),
                    ),
                  ),
                ),
              ],
            ),
          ),




           SizedBox(height: ResponsiveHelper.spacing(8)),

          // Title and Bookmark Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomImage(imageSrc: AppAssets.saveCard),
            ],
          ),
          SizedBox(height: ResponsiveHelper.spacing(8)),

          // Add to Cart Button
          InkWell(
            onTap: onAddToCart,
            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
            child: Container(
              width: double.infinity,
              padding:  ResponsiveHelper.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color:  AppColors.primaryShadeColor, // Light orange/peach background
                borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

               CustomImage(imageSrc: AppAssets.cart),
                 SizedBox(width: ResponsiveHelper.spacing(10)),
                  Text(
                    'Add to Cart',
                    style:context.bodySmall.copyWith(color: AppColors.primaryColor)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}