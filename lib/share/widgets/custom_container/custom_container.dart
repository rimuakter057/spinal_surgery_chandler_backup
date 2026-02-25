import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';



class CustomContainer extends StatelessWidget {
  final Widget child; // Required
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding; // <-- updated
  final EdgeInsetsGeometry? margin;
 final double?borderWidth;
  const CustomContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.radius,
    this.width,
    this.height,
    this.padding,
    this.margin, this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??  EdgeInsets.all(ResponsiveHelper.padding(12),), // default 8
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? ResponsiveHelper.borderRadius(8),),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width:borderWidth??1
        ),
      ),
      child: child,
    );
  }
}

