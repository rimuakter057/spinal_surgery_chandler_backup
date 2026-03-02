import 'package:chandler_app/feature/auth/presentation/widgets/title_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key, required this.title, required this.hint, this.validator, required this.controller,
  });
  final String title;
  final String hint;
  final String? Function(String?)?validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: context.labelLarge,),



        SizedBox(height: ResponsiveHelper.height(8) ,),
        TextFormField(
          style: context.bodyMedium,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

