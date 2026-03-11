import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfHelper {
  PdfHelper._(); // ✅ instance বানানো যাবে না

  /// ✅ যেকোনো screen এ use করো
  static Widget buildPdfViewer({
    required String pdfUrl,
    double heightFactor = 0.45, // default screen height এর 45%
  }) {
    if (pdfUrl.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final pdfHeight = MediaQuery.of(context).size.height * heightFactor;
        return SizedBox(
          height: pdfHeight,
          width: double.infinity,
          child: SfPdfViewer.network(pdfUrl),
        );
      },
    );
  }
}