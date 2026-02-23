import 'package:flutter/material.dart';

class DialogButtonWidget extends StatelessWidget {
  const DialogButtonWidget({
    super.key, required this.title,required this.onTap,
  });
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
    );
  }
}