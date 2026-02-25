import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  const CountButton({super.key, required this.onTap, required this.title});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: ResponsiveHelper.symmetric(horizontal: 12, vertical: 2),
      backgroundColor: AppColors.navUnselectedColor,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: context.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: ResponsiveHelper.fontSize(14),
          ),
        ),
      ),
    );
  }
}
