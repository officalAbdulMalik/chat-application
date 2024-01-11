import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFields extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String hint;
  final IconData icon;
  final String errorMessage;
  final bool? isPasswordField;

  MyTextFields({
    Key? key,
    this.isPasswordField = false,
    required this.errorMessage,
    required this.hint,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordField!,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffFDDBDD)),
            borderRadius: BorderRadius.circular(16.sp)),
        hintText: hint,

        // labelText: title,
      ),
    );
  }
}
