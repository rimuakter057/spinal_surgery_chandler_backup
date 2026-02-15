import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: ResponsiveHelper.height(48),
      width: double.infinity,
      radius: ResponsiveHelper.borderRadius(12), // rounded corners,
      backgroundColor: AppColors.searchBarBgColor,
      child: TextField(
        decoration: InputDecoration(
          fillColor: AppColors.searchBarBgColor,
          filled: true,
          hintText: "Search here...", // placeholder text
          hintStyle: context.bodyMedium.copyWith(
            color: AppColors.searchTextColor,
          ),

          prefixIconConstraints: BoxConstraints(
            minHeight: ResponsiveHelper.height(20),
            minWidth: ResponsiveHelper.width(20),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: ResponsiveHelper.padding(16),),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
