import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/action_text_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/remember_forgot_row.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/helper/shared_prefe/shared_prefe.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  void _loadRememberedEmail() async {
    final rememberedEmail = await SharePrefsHelper.getString(
      AppConstant.rememberedEmail,
    );
    final rememberedPassword = await SharePrefsHelper.getString(
      AppConstant.rememberedPassword,
    );
    final isRemember =
        await SharePrefsHelper.getBool(AppConstant.rememberMe) ?? false;

    if (isRemember &&
        rememberedEmail.isNotEmpty &&
        rememberedPassword.isNotEmpty) {
      setState(() {
        emailController.text = rememberedEmail;
        passwordController.text = rememberedPassword;
        rememberMe = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(24));
    return Scaffold(
      appBar: CustomAppBar(title: AppText.login,isBack: false,),

      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ///login image
              Center(
                child: CustomImage(
                  imageSrc: AppAssets.logo,
                  height: ResponsiveHelper.iconSize(132),
                  width: ResponsiveHelper.iconSize(132),
                ),
              ),
              gap,
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

              ///password field
              InputPassFieldWidget(
                title: AppText.password,
                hint: AppText.enterPassword,
                controller: passwordController,
              ),
              gap,
              RememberForgotRow(
                rememberMe: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                },
                onForgotPassword: () {
                  context.pushNamed(RoutesPath.forgotPasswordScreen);
                },
              ),
              gap,
              gap,
              Obx(() {
                final isLoading = authController.inProgressLogIn.value;
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
                        onPressed: () => onTapLogin(),
                        child: Text(AppText.signIn),
                      );
              }),

              SizedBox(height: ResponsiveHelper.height(12)),
              ActionTextWidget(
                underlineColor: AppColors.primaryColor,
                prefixText: AppText.dontHaveAccount,
                actionText: AppText.signUp,
                onActionTapped: () {
                  context.pushNamed(RoutesPath.signUpScreen);
                },
                isUnderline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapLogin() async {
    debugPrint("===================click sign in=====================");
    // ✅ CHECK EMAIL
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // email empty check
    if (email.isEmpty) {
      CustomSnackbar.error(context, "Please enter your email");
      return;
    }

    // email format check
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
    );
    if (!emailRegex.hasMatch(email)) {
      CustomSnackbar.error(context, "Please enter a valid email address");
      return;
    }
    {
      // password empty check
      if (password.isEmpty) {
        CustomSnackbar.error(context, "Please enter your password");
        return;
      }

      debugPrint(
        "===================authcontroller=======================================",
      );
      bool success = await authController.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (success) {
        // ✅ Remember Me
        if (rememberMe) {
          await SharePrefsHelper.setString(AppConstant.rememberedEmail, email);
          await SharePrefsHelper.setString(
            AppConstant.rememberedPassword,
            password,
          );
          await SharePrefsHelper.setBool(AppConstant.rememberMe, true);
        } else {
          await SharePrefsHelper.remove(AppConstant.rememberedEmail);
          await SharePrefsHelper.remove(AppConstant.rememberedPassword);
          await SharePrefsHelper.setBool(AppConstant.rememberMe, false);
        }

        context.goNamed(RoutesPath.mainNavScreen);
      } else {
        CustomSnackbar.error(context, authController.errorMessage.value);
      }
    }
  }
}
