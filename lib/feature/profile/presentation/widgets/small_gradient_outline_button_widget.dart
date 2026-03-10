import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class SmallOutlineGradientButtonRow extends StatelessWidget {
  const SmallOutlineGradientButtonRow({
    super.key,
    required this.outlineTitle,
    required this.outlineOnTap,
    required this.gradientTitle,
    required this.gradientOnTap,
  });

  final String gradientTitle;
  final String outlineTitle;
  final VoidCallback gradientOnTap;
  final VoidCallback outlineOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: outlineOnTap,
            child: Container(
              width: double.infinity,
              padding: ResponsiveHelper.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.borderRadius(12),
                ),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: ResponsiveHelper.width(1),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                outlineTitle,
                style: context.bodyLarge.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(18)),

        Expanded(
          child: GestureDetector(
            onTap: gradientOnTap,
            child: Container(
              width: double.infinity,
              padding: ResponsiveHelper.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryColor,
              ),
              child: Text(
                gradientTitle,
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
