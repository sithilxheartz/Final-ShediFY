import 'package:firebase_auth_tutorials/services/authenticater_service.dart';
import 'package:firebase_auth_tutorials/widgets/login_button.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  // function
  final Function toggle;
  const Login({super.key, required this.toggle});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // reference for the AuthServices class
  final AuthteServices _auth = AuthteServices();
  // from key
  final _formKey = GlobalKey<FormState>();
  // emal and pass states
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 200),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png", width: 80),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ShediFY",
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "Ease Your Life With Us",
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome,",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator:
                            (val) =>
                                val?.isEmpty == true
                                    ? "Enter Valid Email"
                                    : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 12.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        obscureText: true,
                        validator:
                            (val) =>
                                val!.length < 6 ? "Enter Valid Password" : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 12.0,
                          ),
                        ),
                      ),
                    ),
                    Text(error, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await _auth.loginusingEmailAndPassword(
                          email,
                          password,
                        );
                        if (result == null) {
                          setState(() {
                            error = "Invalid Email or Password!";
                          });
                        }
                      },
                      child: MainButton(buttonTitle: "Sign In"),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await _auth.siginAnonymously();
                      },
                      child: MainButton(buttonTitle: "Login as a Guest"),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account?"),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Text(
                      textAlign: TextAlign.center,
                      "© 2025 ShediFY - All rights reserved.",
                      style: TextStyle(color: subTextColor, fontSize: 13),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Privacy Policy | Terms of Service",
                      style: TextStyle(color: subTextColor, fontSize: 13),
                    ),
                    //ElevatedButton(
                    //onPressed: () async {
                    //dynamic result = await _auth.siginAnonymously();
                    //if (result == null) {
                    //print("Erorr in Anonymous Login");
                    //} else {
                    //print("Login Anonymous");
                    //print(result.uid);
                    //}
                    //},
                    //child: const Text("Login Anonymously"),
                    //),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
