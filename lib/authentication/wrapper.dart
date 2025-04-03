import 'package:firebase_auth_tutorials/authentication/authenticater.dart';
import 'package:firebase_auth_tutorials/pages/dashboard_main.dart';
import 'package:firebase_auth_tutorials/models/user_model.dart';
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
      return MainDashboard();
    }
  }
}
