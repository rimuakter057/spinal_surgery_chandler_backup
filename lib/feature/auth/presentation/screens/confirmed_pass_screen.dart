import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class ConfirmedPasswordScreen extends StatelessWidget {
  ConfirmedPasswordScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Widget gap=SizedBox(height:ResponsiveHelper.height(24));
    return Scaffold(
      appBar: CustomAppBar(title: AppText.confirmPassword),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            children: [
              SizedBox(height: ResponsiveHelper.height(120),),

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
                controller: confirmedPasswordController,
              ),

              gap,
              gap,
              ElevatedButton(child:  Text(AppText.resetPassword), onPressed: () {
                context.pushNamed(RoutesPath.loginScreen);
              }),

            ],
          ),
        ),
      ),
    );
  }
}
