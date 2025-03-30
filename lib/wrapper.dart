import 'package:firebase_auth_tutorials/authenticate.dart';
import 'package:firebase_auth_tutorials/home.dart';
import 'package:firebase_auth_tutorials/userModel.dart';
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
