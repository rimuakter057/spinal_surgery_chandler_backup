import 'dart:io';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/profile/presentation/widgets/small_gradient_outline_button_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_profile_image.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';

import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = _authController.profileData.value;
    if (profile != null) {
      nameController.text = profile['full_name'] ?? '';
      emailController.text = profile['email'] ?? '';
      phoneController.text = profile['phone'] ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }



  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.spacing(24));

    return Scaffold(
      appBar: CustomAppBar(title: AppText.editProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Obx(() {
            final profile = _authController.profileData.value;

            return Column(
              children: [
                /// Avatar
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _selectedImage != null
                          ? Container(
                        width: ResponsiveHelper.iconSize(78),
                        height: ResponsiveHelper.iconSize(78),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : CustomProfileAvatar(
                        width: ResponsiveHelper.iconSize(78),
                        height: ResponsiveHelper.iconSize(78),
                        image: profile?['avatar'],
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          ResponsiveHelper.borderRadius(4),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: CustomImage(imageSrc: AppAssets.camera),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveHelper.spacing(12)),

                Text(profile?['full_name'] ?? '', style: context.bodyLarge),
                SizedBox(height: ResponsiveHelper.spacing(4)),
                Text(
                  profile?['address'] ?? '',
                  style: context.bodyMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),

                SizedBox(height: ResponsiveHelper.spacing(16)),

                /// Full Name — editable
                InputFieldWidget(
                  title: AppText.fullName,
                  hint: AppText.enterFullName,
                  controller: nameController,
                ),
                gap,

                /// Email — read only
                InputFieldWidget(
                  title: AppText.email,
                  hint: AppText.enterEmail,
                  controller: emailController,
                  readOnly: true,
                ),
                gap,

                /// Phone — read only
                InputFieldWidget(
                  title: AppText.phoneNumber,
                  hint: AppText.enterPhone,
                  controller: phoneController,
                  readOnly: true,
                ),

                gap,
                gap,
                gap,

                /// Buttons

                     SmallOutlineGradientButtonRow(
                    outlineTitle: AppText.cancel,
                    gradientTitle: AppText.save,

                    outlineOnTap: (){
                      debugPrint ("cancel");
                    },
                    gradientOnTap: _handleSave,
                  ),

              ],
            );
          }),
        ),
      ),
    );
  }


  Future<void> _handleSave() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      CustomSnackbar.error(context, 'Full name cannot be empty');
      return;
    }


    final originalName = _authController.profileData.value?['full_name'] ?? '';
    if (name == originalName && _selectedImage == null) {
      CustomSnackbar.error(context, 'Nothing to update');
      return;
    }

    final success = await _authController.updateProfile(
      fullName: name,
      avatar: _selectedImage,
    );

    if (!mounted) return;

    if (success) {
      CustomSnackbar.success(
        context: context,
        message: 'Profile updated successfully',
      );
      context.pop();
    } else {
      CustomSnackbar.error(
        context,
        _authController.errorMessage.value,
      );
    }
  }


}