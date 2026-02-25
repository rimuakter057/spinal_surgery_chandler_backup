import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/loading/loading_widget.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  const CustomButton({
    required this.text,
    this.onTap,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {




    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8),),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: ResponsiveHelper.height(48),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8),)),
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget(color: AppColors.white);
    } else {
      return Text(
        text,
        style: context.titleMedium.copyWith(color: AppColors.white),
      );
    }
  }
}

