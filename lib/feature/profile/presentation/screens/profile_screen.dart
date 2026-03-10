import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_profile_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.fetchProfile();
    });

    return Scaffold(
      appBar: CustomAppBar(title: AppText.profile),
      body: Obx(() {
        final bool isLoading = authController.isLoadingProfile.value;
        final profile = authController.profileData.value;

        return SingleChildScrollView(
          child: Padding(
            padding: ResponsiveHelper.all(16),
            child: Column(
              children: [
                _buildEditProfile(context),

                SizedBox(height: ResponsiveHelper.spacing(12)),
                /// Name
                Text(
                  isLoading ? "" : profile?['full_name'] ?? '',
                  style: context.bodyLarge,
                ),

                SizedBox(height: ResponsiveHelper.spacing(4)),

                /// Address
                Text(
                  isLoading ? "" : profile?['address'] ?? '',
                  style: context.bodyMedium.copyWith(color: AppColors.greyTextColor),
                ),

                SizedBox(height: ResponsiveHelper.spacing(16)),

                _buildDeliveryDetails(context, profile, isLoading),
              ],
            ),
          ),
        );
      }),
    );
  }

  Stack _buildEditProfile(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomProfileAvatar(
          width: ResponsiveHelper.iconSize(78),
          height: ResponsiveHelper.iconSize(78),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(RoutesPath.editProfileScreen);
          },
          child: Container(
            padding: ResponsiveHelper.all(4),
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              shape: BoxShape.circle,
            ),
            child: CustomImage(imageSrc: AppAssets.edit),
          ),
        ),
      ],
    );
  }

  CustomContainer _buildDeliveryDetails(
      BuildContext context,
      Map<String, dynamic>? profile,
      bool isLoading,
      ) {
    return CustomContainer(
      backgroundColor: AppColors.navUnselectedColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name
          Text(
            AppText.nameLabel,
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),
          SizedBox(height: ResponsiveHelper.spacing(4)),
          Text(
            isLoading ? "" : profile?['full_name'] ?? '',
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),

          SizedBox(height: ResponsiveHelper.spacing(8)),

          /// Address
          Text(
            AppText.addressLabel,
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),
          SizedBox(height: ResponsiveHelper.spacing(4)),
          Text(
            isLoading ? "" : profile?['address'] ?? '',
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),

          SizedBox(height: ResponsiveHelper.spacing(8)),

          /// Email
          Text(
            AppText.emailLabel,
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),
          SizedBox(height: ResponsiveHelper.spacing(4)),
          Text(
            isLoading ? "" : profile?['email'] ?? '',
            style: context.bodyMedium.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }

}