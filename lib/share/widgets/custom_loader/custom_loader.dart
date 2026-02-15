import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/loading/spin_kit_circle.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context)
  {
    return SpinKitCircle(
      color: AppColors.primaryColor,
      // color: AppColors.appBarBackground,
      size: ResponsiveHelper.height(60),
    );
  }
}
