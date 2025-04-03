import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

var textInputDeco = InputDecoration(
  hintText: "Email",

  hintStyle: const TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
  contentPadding: EdgeInsets.symmetric(horizontal: 20),

  filled: true,
  fillColor: Colors.black.withOpacity(0.2),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: mainColor, width: 1.5),
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(
    // borderSide: BorderSide(color: iconBgColor, width: 1.5),
    borderRadius: BorderRadius.circular(20),
  ),
);
