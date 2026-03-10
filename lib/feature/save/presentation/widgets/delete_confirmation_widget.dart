import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

// ─── Delete Confirmation Dialog ───────────────────────────────────────────────
class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  const DeleteConfirmationDialog({
    super.key,
    this.title = 'Delete Item',
    this.message = 'Are you sure you want to delete this?',
    required this.onConfirm,
    this.confirmText = 'Delete',
    this.cancelText = 'Cancel',
  });

  static Future<bool?> show({
    required BuildContext context,
    String title = 'Delete Item',
    String message = 'Are you sure you want to delete this?',
    required VoidCallback onConfirm,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => DeleteConfirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal:
            (MediaQuery.of(context).size.width - ResponsiveHelper.width(300)) /
            2,
        vertical: 24,
      ),
      child: Container(
        width: ResponsiveHelper.width(300),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Content ─────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  8
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.bodyLarge,
                  ),
                  SizedBox(height: ResponsiveHelper.spacing(10)),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),

            // ── Divider ─────────────────────────────────────────────────────
            CustomDivider(),
            SizedBox(height: ResponsiveHelper.spacing(12)),
            // ── Buttons ─────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        padding: ResponsiveHelper.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: AppColors.dividerColor),
                        ),
                        backgroundColor: AppColors.white,
                      ),
                      child: Text(
                        cancelText,
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.spacing(8)),
                  // Delete Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        padding: ResponsiveHelper.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.borderRadius(12),
                          ),
                        ),
                      ),
                      child: Text(
                        confirmText,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
