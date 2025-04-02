import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonTitle;
  const MainButton({super.key, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: someIconColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
