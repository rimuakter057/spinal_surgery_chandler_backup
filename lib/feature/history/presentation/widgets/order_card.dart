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
    final width = MediaQuery.of(context).size.width;

    print('Screen width: $width');

    return CustomContainer(
      backgroundColor: AppColors.containerGreyBgColor.withAlpha(70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${AppText.orderId}$orderId", style: context.bodyMedium),
              Text("${AppText.totalItem}$totalItem", style: context.bodyMedium),

              Text("${AppText.deliveredDate}$date", style: context.bodyMedium),
            ],
          ),


              CustomContainer(
                //height: width>400? 30.h:38.h,
                height: ResponsiveHelper.height(38),
                radius: ResponsiveHelper.borderRadius(50),
                padding: ResponsiveHelper.symmetric(horizontal: 10, vertical: 8),
                backgroundColor:AppColors.green,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                 "Complete",
                  style: context.bodyMedium.copyWith(
                    // fontSize: width>400?12:14,
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