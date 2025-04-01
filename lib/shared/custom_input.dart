import 'package:flutter/material.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 13),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: iconColor),
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13.0,
            horizontal: 12.0,
          ),
        ),
      ),
    );
  }
}
