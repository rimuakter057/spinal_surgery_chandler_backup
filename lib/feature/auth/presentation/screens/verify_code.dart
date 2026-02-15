import 'package:chandler_app/feature/auth/presentation/widgets/forgot-code_heading_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/otp_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key});
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(title: AppText.emailVerify),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            children: [

              ForgotCodeHeadingWidget(title: AppText.enterVerificationCode, subtitle:AppText.verificationSent,),


              SizedBox(height: ResponsiveHelper.height(64) ,),
              ///otp field==========================================
              OtpFieldWidget(
                controller: _otpController,
                onCompleted: (value) {
                  debugPrint("OTP Completed: $value");
                },
              ),
              SizedBox(height: ResponsiveHelper.height(120) ,),
      ElevatedButton(onPressed: (){}, child: Text(
          AppText.cancel

      ))

            ],
          ),
        ),
      ),
    );
  }
}


