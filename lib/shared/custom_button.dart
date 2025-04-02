import 'package:flutter/material.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Color BgColor;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.labelText,
    required this.onPressed,
    this.BgColor = mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          backgroundColor: BgColor,
        ),
        child: Text(
          labelText,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
