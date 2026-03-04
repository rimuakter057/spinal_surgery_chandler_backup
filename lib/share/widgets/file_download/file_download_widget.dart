import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileDownloadWidget extends StatelessWidget {
  const FileDownloadWidget({
    super.key,
    required this.fileUrl,
    this.label = "Download",
    this.iconColor,
    this.textStyle,
  });

  final String fileUrl;
  final String label;
  final Color? iconColor;
  final TextStyle? textStyle;

  /// 🔥 canLaunchUrl বাদ — সরাসরি launchUrl, error হলে catch করবে
  Future<void> _download(BuildContext context) async {
    if (fileUrl.isEmpty) return;

    try {
      final uri = Uri.parse(fileUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Download error: $e");
      if (context.mounted) {
        CustomSnackbar.error(context, "Cannot open file");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? Colors.grey;

    return GestureDetector(
      onTap: fileUrl.isNotEmpty ? () => _download(context) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.download_rounded,
            color: fileUrl.isNotEmpty ? color : Colors.grey.shade400,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: textStyle ?? TextStyle(color: color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}