import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';



class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: AppColors.primaryColor,
      color: AppColors.white,
      child: child,
    );
  }
}
