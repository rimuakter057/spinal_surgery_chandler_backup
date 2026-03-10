import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/profile/presentation/widgets/small_gradient_outline_button_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_profile_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.spacing(24));
    return Scaffold(
      appBar: CustomAppBar(title: AppText.editProfile),

      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            children: [
              _buildEditProfile(),

              SizedBox(height: ResponsiveHelper.spacing(12)),

              Text("Banedict Fring Dron", style: context.bodyLarge),
              SizedBox(height: ResponsiveHelper.spacing(4)),
              Text(
                "Great Falls, Marylan",
                style: context.bodyMedium.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
              SizedBox(height: ResponsiveHelper.spacing(16)),
              Column(
                children: [
                  ///name field
                  InputFieldWidget(
                    title: AppText.fullName,
                    hint: AppText.enterFullName,
                    controller: nameController,
                  ),
                  gap,

                  ///email field
                  InputFieldWidget(
                    title: AppText.email,
                    hint: AppText.enterEmail,
                    controller: emailController,
                  ),
                  gap,

                  ///phone field
                  InputFieldWidget(
                    title: AppText.phoneNumber,
                    hint: AppText.enterPhone,
                    controller: emailController,
                  ),

                  gap,
                  gap,
                  gap,

                  ///  SmallGradientOutlineButtonRow=================================================================
                  SmallOutlineGradientButtonRow(
                    outlineTitle: AppText.cancel,
                    gradientTitle: AppText.save,

                    gradientOnTap: () {},
                    outlineOnTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildEditProfile() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomProfileAvatar(
          width: ResponsiveHelper.iconSize(78),
          height: ResponsiveHelper.iconSize(78),
        ),

        /// Edit Button
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.borderRadius(4)),
          decoration: BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.circle,
          ),
          child: CustomImage(imageSrc: AppAssets.camera),
        ),
      ],
    );
  }
}
