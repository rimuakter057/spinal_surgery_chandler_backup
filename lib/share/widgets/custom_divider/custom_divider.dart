import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';



class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key, this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,  // full screen width
      child: Divider(
        color:color??AppColors.dividerColor,
        thickness: 1,
      ),
    );
  }
}