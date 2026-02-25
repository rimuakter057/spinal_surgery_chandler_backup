import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart'; // ❗ flutter_html import

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  // Example static data, তুমি API থেকে নিলে replace করতে পারো
  final String termsDescription = """
    <h3>Terms Condition</h3>
    <p>This is your termsAndConditions content. You can write HTML here.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.termsAndConditions),
      body: SingleChildScrollView(
        child: Html(
          data: termsDescription,
          style: {
            "body": Style(
              fontSize: FontSize(ResponsiveHelper.fontSize(14)),
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontFamily: AppConfig.questrial,
            ),
          },
        ),
      ),
    );
  }
}
