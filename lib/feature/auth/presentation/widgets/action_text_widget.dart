import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';


class ActionTextWidget extends StatelessWidget {
  final String prefixText; // Normal text
  final String actionText; // Clickable text
  final VoidCallback onActionTapped; // Function when link tapped
  final Color? prefixColor;
  final Color? actionColor;
  final double? fontSize;
  final double? fontSizeAction;
  final bool isUnderline;
  final FontWeight? fontWeight;
  final FontWeight? fontWeightAction;
  final Color? underlineColor;
  const ActionTextWidget({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onActionTapped,
    this.prefixColor ,
    this.actionColor ,
    this.fontSize,
    this.fontSizeAction,
    this.isUnderline=false,
    this.underlineColor,
    this.fontWeight,
    this.fontWeightAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(prefixText,
          style: GoogleFonts.poppins(
            fontSize:fontSize?? ResponsiveHelper.fontSize(14) ,
            fontWeight:fontWeight?? FontWeight.w400,
            color:prefixColor??AppColors.greyTextColor,
          ),
          )
        ),
        GestureDetector(
          onTap: onActionTapped,
          child: Padding(
            padding:  EdgeInsets.only(left: ResponsiveHelper.width(4) ,),
            child:Text(
              actionText,
              style: GoogleFonts.poppins(

                fontSize:fontSizeAction?? ResponsiveHelper.fontSize(14) ,
                fontWeight:fontWeightAction?? FontWeight.w400,
                color:actionColor?? AppColors.primaryColor,
                decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
                decorationColor:
                isUnderline ? (underlineColor ?? AppColors.primaryColor) : null,
                decorationThickness: isUnderline ? 2 : null,
              ),

            ),

          ),
        ),
      ],
    );
  }
}
