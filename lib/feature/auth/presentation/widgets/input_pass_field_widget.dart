import 'package:chandler_app/feature/auth/presentation/widgets/password_field_widget.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/title_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class InputPassFieldWidget extends StatelessWidget {
  const InputPassFieldWidget({
    super.key, required this.title, required this.hint, required this.controller, this.validator,
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
        TitleWidget(title: title),
        SizedBox(height: ResponsiveHelper.height(8) ,),
        PasswordFieldWidget(
          validator: validator,
          hint: hint,
          controller: controller,
        ),
      ],
    );
  }
}