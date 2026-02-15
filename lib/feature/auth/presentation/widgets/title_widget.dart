import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';


class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,style: context.bodyLarge,);
  }
}

