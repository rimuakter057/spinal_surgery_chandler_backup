import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/forgot-code_heading_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/otp_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key, required this.email});
  final String email;

  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.emailVerify),

      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                ForgotCodeHeadingWidget(
                  title: AppText.enterVerificationCode,
                  subtitle:  "We've sent a 6-digit code to ${maskEmail(email)}",
                ),

                SizedBox(height: ResponsiveHelper.height(64)),

                ///otp field==========================================
                OtpFieldWidget(
                  controller: otpController,
                  onCompleted: (value) {
                    debugPrint("OTP Completed: $value");
                  },
                ),
                SizedBox(height: ResponsiveHelper.height(120)),
                ///verify code button===================================
                Obx(() {
                  final isLoading = authController.inProgressVerification.value;
                  return isLoading
                      ? SizedBox(
                    height: ResponsiveHelper.iconSize(24),
                    width: ResponsiveHelper.iconSize(24),
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () => onTapVerification(context),
                    child: Text(AppText.verify),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapVerification(BuildContext context) async {
    // email empty check
    if (otpController.text.trim().isEmpty) {
      CustomSnackbar.error(context, "Otp cannot be empty");

      return;
    }

    if (!_key.currentState!.validate()) return;

    bool success = await authController.verifyOtp(
      email: email,
      otp:
          int.tryParse(otpController.text.trim()) ?? 0,
    );

    if (success) {
      context.pushNamed(RoutesPath.confirmedPassScreen);

      otpController.clear();
    } else {
      CustomSnackbar.error(context, authController.errorMessage.value);
    }
  }
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email;

  final name = parts[0];
  final domain = parts[1];

  final visible = name.length >= 2 ? name.substring(0, 2) : name;

  return '$visible***@$domain';
}