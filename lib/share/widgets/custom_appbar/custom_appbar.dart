import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? leadingIcon;
  final VoidCallback? onBack;
  final double leadingWidth;
  final double iconSize;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onBack,
    this.leadingWidth = 48,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leadingWidth: leadingWidth.w,
      leading: GestureDetector(
        onTap:onBack?? (){
          context.pop();

        },




        child: Center(
          child: CustomImage(
            imageSrc:leadingIcon?? AppAssets.back,
            height: iconSize.h,
            width: iconSize.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text(
        title,
        style: context.titleSmall,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
