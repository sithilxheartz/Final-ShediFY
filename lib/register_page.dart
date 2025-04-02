import 'package:firebase_auth_tutorials/auth_services.dart';
import 'package:firebase_auth_tutorials/shared/main_button.dart';
import 'package:firebase_auth_tutorials/shared/styles.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  // function
  final Function toggle;

  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthteServices _auth = AuthteServices();
  // from key
  final _formKey = GlobalKey<FormState>();
  // emal and pass states
  String error = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Icon(
                      Icons.local_gas_station,
                      size: 70,
                      color: someIconColor,
                    ),
                  ),
                  Text(
                    "ShediFY",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: someIconColor,
                    ),
                  ),
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: someIconColor,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: textInputDeco,
                      validator:
                          (val) =>
                              val?.isEmpty == true ? "Enter Valid Email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDeco.copyWith(hintText: "Password"),
                      validator:
                          (val) =>
                              val!.length < 6 ? "Enter Valid Password" : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // error text
                    Text(error, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          // error
                          setState(() {
                            error = "Please enter a valid email";
                          });
                        }
                      },
                      child: MainButton(buttonTitle: "Register"),
                    ),
                    SizedBox(height: 20),
                    Text("Login with Social Accounts"),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset("assets/ggogle.png", height: 90),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have an Account?"),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
