import 'package:firebase_auth_tutorials/authentication/login_page.dart';
import 'package:firebase_auth_tutorials/authentication/register_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool loginPage = true;

  // toggle page
  void switchPages() {
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage == true) {
      return Login(toggle: switchPages);
    } else {
      return Register(toggle: switchPages);
    }
  }
}
