import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool> onChanged;
  final VoidCallback onForgotPassword;

  final TextStyle? textStyle;

  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onChanged,
    required this.onForgotPassword,

    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Remember Me
        Row(
          children: [
            Transform.scale(
              scale: ResponsiveHelper.isTablet ? 1.1 : 0.85,
              child: Switch(
                value: rememberMe,
                onChanged: onChanged,
                activeColor: AppColors.primaryColor,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.greyTextColor,

                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(4)),
            Text(AppText.rememberMe, style: context.bodyMedium),
          ],
        ),

        const Spacer(),

        /// Forgot Password
        GestureDetector(
          onTap: onForgotPassword,
          child: Text(
            "Forgot Password?",
            style: GoogleFonts.poppins(
              fontSize: ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
              decorationThickness: ResponsiveHelper.height(1.2),
            ),
          ),
        ),
      ],
    );
  }
}
