import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/action_text_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class SignUpScreen extends StatelessWidget {

  SignUpScreen({super.key, });
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(24));
    return Scaffold(
      appBar: AppBar(title: Text(AppText.signUp,style: context.titleSmall,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
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
                controller: emailController,
              ),
              gap,

              ///password field
              InputPassFieldWidget(
                title: AppText.password,
                hint: AppText.enterPassword,
                controller: passwordController,
              ),
              gap,

              ///confirmed password field
              InputPassFieldWidget(
                title: AppText.confirmPassword,
                hint: AppText.enterConfirmedPassword,
                controller: confirmedPassController,
              ),

              gap,
              gap,
              gap,
  ElevatedButton(onPressed: (){}, child: Text(AppText.signUp)),
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
    );
  }
}
