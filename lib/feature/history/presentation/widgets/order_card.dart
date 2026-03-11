import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';


class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    this.widgetHistory,
    required this.orderId,
    required this.totalItem,
    required this.totalPrice,
    required this.date,
    this.status,
    this.statusBgColor,
  });

  final Widget? widgetHistory;
  final String? status;
  final String orderId;
  final String totalItem;
  final String totalPrice;
  final String date;
  final Color? statusBgColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColors.fillColor,
      padding: ResponsiveHelper.symmetric(vertical: 20,horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Left — takes all remaining space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${AppText.orderId}$orderId",
                  style: context.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "${AppText.totalItem}$totalItem",
                  style: context.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "${AppText.deliveredDate}$date",
                  style: context.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),

          SizedBox(width: ResponsiveHelper.spacing(8)),

          /// Right — fixed size badge, never grows
          CustomContainer(
            height: ResponsiveHelper.height(38),
            radius: ResponsiveHelper.borderRadius(50),
            padding: ResponsiveHelper.symmetric(horizontal: 10, vertical: 8),
            backgroundColor: statusBgColor ?? AppColors.green,
            child: Text(
              status ?? "Complete",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}