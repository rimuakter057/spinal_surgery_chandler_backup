import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/forgot-code_heading_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.forgotPasswordTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                ForgotCodeHeadingWidget(
                  title: AppText.forgotPasswordTitle,
                  subtitle: AppText.forgotPasswordSubtitle,
                ),

                SizedBox(height: ResponsiveHelper.height(64)),

                ///email field
                InputFieldWidget(
                  title: AppText.enterYourEmail,
                  hint: AppText.enterEmail,
                  controller: emailController,
                ),
                SizedBox(height: ResponsiveHelper.height(120)),

                // forgot  Button
                Obx(() {
                  return ElevatedButton(
                    onPressed: authController.inProgressForgot.value
                        ? () {}
                        : () => onTapForgot(context),

                    child: authController.inProgressForgot.value
                        ? CircularProgressIndicator(color: AppColors.white)
                        : Text(AppText.sendOtp),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapForgot(BuildContext context) async {
    // email empty check
    if (emailController.text.trim().isEmpty) {
      CustomSnackbar.error(context, "Email cannot be empty");

      return;
    }

    if (!_key.currentState!.validate()) return;

    bool success = await authController.forgot(
      email: emailController.text.trim(),
    );

    if (success) {
      context.pushNamed(
        RoutesPath.verifyCodeScreen,
        extra: emailController.text.trim(),
      );

      emailController.clear();
    } else {
      CustomSnackbar.error(context, authController.errorMessage.value);
    }
  }
}
