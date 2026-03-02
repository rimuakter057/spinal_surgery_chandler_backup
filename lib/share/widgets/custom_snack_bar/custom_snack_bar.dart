import 'package:flutter/material.dart';

class CustomSnackbar {

  /// ✅ SUCCESS
  static void success(BuildContext context, String message) {

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(

        SnackBar(

          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),

          backgroundColor: Colors.green,

          behavior: SnackBarBehavior.floating, // ✅ small letter

          margin: const EdgeInsets.all(12),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          duration: const Duration(seconds: 2),

        ),

      );

  }


  /// ❌ ERROR
  static void error(BuildContext context, String message) {

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(

        SnackBar(

          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),

          backgroundColor: Colors.red,

          behavior: SnackBarBehavior.floating, // ✅ small letter

          margin: const EdgeInsets.all(12),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          duration: const Duration(seconds: 3),

        ),

      );

  }

}