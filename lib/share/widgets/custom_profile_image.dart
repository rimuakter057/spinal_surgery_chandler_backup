import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';


class CustomProfileAvatar extends StatelessWidget {
  const CustomProfileAvatar({
    super.key, this.height, this.width, this.image,
  });

  final double?height;
  final double?width;
  final String?image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width?? ResponsiveHelper.height(38), // avatar size
      height:height?? ResponsiveHelper.width(38),
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        image: DecorationImage(
          image: NetworkImage(image??AppConstant.unknown),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}