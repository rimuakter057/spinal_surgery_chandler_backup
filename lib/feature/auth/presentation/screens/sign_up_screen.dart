import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/action_text_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPassController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(24));
    return Scaffold(
      appBar: AppBar(title: Text(AppText.signUp, style: context.titleSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ///name field
                InputFieldWidget(
                  title: AppText.fullName,
                  hint: AppText.enterFullName,
                  controller: nameController,
                  validator: (v) =>
                      v!.isEmpty ? 'Please enter your full name' : null,
                ),
                gap,

                ///email field
                InputFieldWidget(
                  title: AppText.email,
                  hint: AppText.enterEmail,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                ),
                gap,

                ///phone field
                InputFieldWidget(
                  title: AppText.phoneNumber,
                  hint: AppText.enterPhone,
                  controller: phoneController,
                  validator: (v) =>
                      v!.isEmpty ? 'Please enter your phone number' : null,
                ),
                gap,

                ///password field
                InputPassFieldWidget(
                  title: AppText.password,
                  hint: AppText.enterPassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                gap,

                ///confirmed password field
                InputPassFieldWidget(
                  title: AppText.confirmPassword,
                  hint: AppText.enterConfirmedPassword,
                  controller: confirmedPassController,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return 'Please confirm your password';
                    if (v != passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),

                gap,
                gap,
                gap,
                //   ElevatedButton(onPressed: (){}, child: Text(AppText.signUp)),

                // Sign Up Button
                Obx(() {
                  return ElevatedButton(
                    onPressed: authController.inProgressSignup.value
                        ? null
                        : () => _onTapSignUp(context),

                    child: authController.inProgressSignup.value
                        ? CircularProgressIndicator(color: AppColors.white)
                        : Text(AppText.signUp),
                  );
                }),

                SizedBox(height: ResponsiveHelper.height(12)),
                ActionTextWidget(
                  underlineColor: AppColors.primaryColor,
                  prefixText: AppText.alreadyHaveAccount,
                  actionText: AppText.signIn,
                  onActionTapped: () {
                    context.pushNamed(RoutesPath.loginScreen);
                  },
                  isUnderline: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ====================== SignUp Action ======================
  void _onTapSignUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    bool success = await authController.signUp(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmedPassController.text.trim(),
    );

    if (success) {
      CustomSnackbar.success(
        context: context,
        message: 'Account created successfully!',
      );
      context.pushNamed(RoutesPath.loginScreen);
    } else {
      CustomSnackbar.error(context, authController.errorMessage.value);
    }
  }
}
