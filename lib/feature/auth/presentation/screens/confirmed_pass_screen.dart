import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/helper/shared_prefe/shared_prefe.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ConfirmedPasswordScreen extends StatefulWidget {
  ConfirmedPasswordScreen({super.key, });


  @override
  State<ConfirmedPasswordScreen> createState() => _ConfirmedPasswordScreenState();
}

class _ConfirmedPasswordScreenState extends State<ConfirmedPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController newPassword = TextEditingController();

  final TextEditingController confirmedPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? token =
      await SharePrefsHelper.getString(AppConstant.refreshToken);

      print("Token:==================== $token");

      // jodi controller call korte chao
      // controller.fetchData(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(24));

    return Scaffold(
      appBar: CustomAppBar(title: AppText.confirmPassword),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: ResponsiveHelper.height(120)),

                ///password field
                InputPassFieldWidget(
                  title: AppText.password,
                  hint: AppText.enterPassword,
                  controller: newPassword,
                ),
                gap,

                ///confirmed password field
                InputPassFieldWidget(
                  title: AppText.confirmPassword,
                  hint: AppText.enterConfirmedPassword,
                  controller: confirmedPasswordController,
                ),

                gap,
                gap,

                // ElevatedButton(
                //   child: Text(AppText.resetPassword),
                //   onPressed: () {
                //     context.pushNamed(RoutesPath.loginScreen);
                //   },
                // ),
                //



                Obx(() {
                  return ElevatedButton(
                    onPressed: authController.inProgressForgot.value
                        ? (){}
                        : () => onTapResetPassword(context),

                    child: authController.inProgressForgot.value
                        ? CircularProgressIndicator(
                      color: AppColors.white,
                    )
                        : Text(AppText.resetPassword),
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapResetPassword(BuildContext context) async {


    // check new password
    if (newPassword.text.trim().isEmpty) {
      CustomSnackbar.error(context, "New password cannot be empty");
      return;
    }

    // // check confirm password
    // if (confirmedPasswordController.text.trim().isEmpty) {
    //   CustomSnackbar.error(context, "Confirm password cannot be empty");
    //   return;
    // }

    // check if passwords match
    if (newPassword.text.trim() != confirmedPasswordController.text.trim()) {
      CustomSnackbar.error(context, "Passwords do not match");
      return;
    }

    if (!_key.currentState!.validate()) return;
    String? token = await SharePrefsHelper.getString(AppConstant.refreshToken);
    debugPrint("Token is================================= $token");


    if (token.isEmpty) {
      debugPrint("Token is null");
      return;
    }
    bool success = await authController.resetOtp(
      password: newPassword.text,
      confirmedPassword:confirmedPasswordController.text ,
      token: token, // use email passed from previous screen
    );

    if (success) {
      CustomSnackbar.success(context, "Password reset successful");
      context.pushNamed(RoutesPath.loginScreen);
      newPassword.clear();
      confirmedPasswordController.clear();
    } else
    {
      CustomSnackbar.error(context, authController.errorMessage.value);
    }
  }
}
