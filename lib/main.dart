import 'package:firebase_auth_tutorials/authServices.dart';
import 'package:firebase_auth_tutorials/userModel.dart';
import 'package:firebase_auth_tutorials/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usermodel?>.value(
      initialData: Usermodel(uid: "null"),
      value: AuthteServices().user,
      child: MaterialApp(home: Wrapper()),
    );
  }
}
