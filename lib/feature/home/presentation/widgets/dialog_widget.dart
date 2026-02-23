import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(16)),
      ),
      child: Container(
          padding: ResponsiveHelper.all(24),
          child: child
      ),
    );
  }
}