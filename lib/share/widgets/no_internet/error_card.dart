// ignore_for_file: deprecated_member_use

import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.onTap,
    this.title,
    this.message,
    this.buttonText,
    this.icon,
    this.iconColor,
    this.showIcon = true,
    this.showShadow = false,
  });

  final VoidCallback onTap;
  final String? title;
  final String? message;
  final String? buttonText;
  final IconData? icon;
  final Color? iconColor;
  final bool showIcon;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        margin:  EdgeInsets.all(ResponsiveHelper.padding(18)),
        padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.padding(20), vertical: ResponsiveHelper.padding(28)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(16)),
          boxShadow:
              showShadow
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (iconColor ?? AppColors.errorColor).withOpacity(0.15),
                ),
                padding:  EdgeInsets.all(ResponsiveHelper.padding(14)),
                child: Icon(
                  icon ?? Icons.error_outline,
                  color: iconColor ?? AppColors.errorColor,
                  size: ResponsiveHelper.iconSize(42)
                ),
              ),
             Gap(ResponsiveHelper.height(16)),
            Text(
              title ?? "Something went wrong",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
             Gap(ResponsiveHelper.height(8)),
            Text(
              message ??
                  "The application has encountered an unknown error.\nPlease try again later.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryColor,
                height: ResponsiveHelper.height(1.4),
              ),
            ),
             Gap(ResponsiveHelper.height(24)),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize:  Size(ResponsiveHelper.width(140), ResponsiveHelper.height(44)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
                ),
              ),
              child: Text(
                buttonText ?? "Try Again",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
