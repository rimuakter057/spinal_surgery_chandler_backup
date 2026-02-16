import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/action_text_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/remember_forgot_row.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height:ResponsiveHelper.height(24));
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:  EdgeInsets.only(left: ResponsiveHelper.padding(16)),
          child: Text("Reform POCT",style: GoogleFonts.poppins(
          
            fontWeight: FontWeight.w400,
            fontSize: ResponsiveHelper.fontSize(20),
            color: AppColors.blackTextColor
          
          
          
          ),),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: ResponsiveHelper.padding(16)),
            child: CustomContainer(
                backgroundColor: AppColors.searchBarBgColor,
                radius: ResponsiveHelper.borderRadius(50),
                child: CustomImage(imageSrc: AppAssets.notification)),
          )
          
          
        ],


      ),






     // appBar: CustomAppBar(title: AppText.login),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ///login image
              Center(
                child: CustomImage(
                  imageSrc:AppAssets.logo,
                  height: ResponsiveHelper.iconSize(132) ,
                  width: ResponsiveHelper.iconSize(132) ,
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

             ElevatedButton(onPressed: (){}, child: Text(AppText.login)),

              SizedBox(height: ResponsiveHelper.height(12) ,),
              ActionTextWidget(
                underlineColor: AppColors.primaryColor,
                prefixText: AppText.dontHaveAccount,
                actionText: AppText.signUp,
                onActionTapped: () {
                  context.pushNamed(RoutesPath.signUpScreen,
                    extra: widget.role,
                  );
                },
                isUnderline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
