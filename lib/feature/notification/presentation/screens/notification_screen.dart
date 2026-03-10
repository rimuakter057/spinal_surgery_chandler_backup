import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.notifications),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: ResponsiveHelper.symmetric(horizontal: 8, vertical: 3),
            child: CustomContainer(
              width: double.infinity,
              backgroundColor: AppColors.primaryShadeColor,
              padding: ResponsiveHelper.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Razco Food reply on your feedback",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.spacing(12)),
                  Text(
                    "Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback",
                    style: context.bodySmall,
                  ),
                  SizedBox(height: ResponsiveHelper.spacing(12)),
                  Text(
                    "20-Dec-2024, 3:00 PM",
                    style: context.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
