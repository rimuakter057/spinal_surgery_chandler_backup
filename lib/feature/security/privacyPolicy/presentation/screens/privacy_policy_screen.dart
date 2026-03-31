import 'package:chandler_app/feature/security/controller/security_controller.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart'; // ❗ flutter_html import

class PrivacyPolicyScreen extends StatelessWidget {

  final SecurityController controller = Get.find<SecurityController>();

  PrivacyPolicyScreen({super.key, }) {
    controller.getSecurityData(AppText.privacyType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.privacyPolicy),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Html(
                data: controller.securityText.value,
                style: {
                  "body": Style(
                    fontSize: FontSize(ResponsiveHelper.fontSize(14)),
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppConfig.questrial,
                  ),
                },
              ),
            );
          }
        },
      ),
    );
  }
}
