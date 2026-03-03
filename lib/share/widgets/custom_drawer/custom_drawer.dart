import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_divider/custom_divider.dart' show CustomDivider;
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(  height: ResponsiveHelper.height(18),),

          /// logo
          Padding(
            padding: ResponsiveHelper.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: SizedBox(
              height: ResponsiveHelper.height(100),
              child: CustomImage(
                imageSrc: AppAssets.logo,
              ),
            ),
          ),

          const CustomDivider(),

          /// menu list
          Padding(
            padding: ResponsiveHelper.all(16),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                // _buildDrawerTitle(
                //   context,
                //   title: "My Cart",
                //   onTap: () {},
                // ),

                // _buildDrawerTitle(
                //   context,
                //   title: "History",
                //   onTap: () {},
                // ),

                _buildDrawerTitle(
                  context,
                  title: AppText.privacyPolicy,
                  onTap: () {
                    context.pushNamed(
                        RoutesPath
                            .privacyPolicyScreen);
                  },
                ),

                _buildDrawerTitle(
                  context,
                  title: AppText.termsAndConditions,
                  onTap: () {
                    context.pushNamed(
                        RoutesPath
                            .termsConditionScreen);
                  },
                ),

                _buildDrawerTitle(
                  context,
                  title: AppText.logOut,
                  onTap: () {
                    context.pushNamed(
                        RoutesPath
                            .loginScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  /// ✅ Drawer title widget (INSIDE CustomDrawer)
  Widget _buildDrawerTitle(
      BuildContext context, {
        required String title,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(bottom: ResponsiveHelper.padding(16)),
        child: Text(
          title,
          style: context.bodyMedium,
        ),
      ),
    );
  }


}