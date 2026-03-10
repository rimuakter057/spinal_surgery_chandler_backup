import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class ForgotCodeHeadingWidget extends StatelessWidget {
  const ForgotCodeHeadingWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: context.bodyLarge),
          SizedBox(height: ResponsiveHelper.height(8)),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(color: AppColors.greyTextColor),
          ),
        ],
      ),
    );
  }
}
