import 'package:firebase_auth_tutorials/authenticater.dart';
import 'package:firebase_auth_tutorials/home_page.dart';
import 'package:firebase_auth_tutorials/model_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // the user data that the provider provides this can be a user data or can be null
    final user = Provider.of<Usermodel?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
