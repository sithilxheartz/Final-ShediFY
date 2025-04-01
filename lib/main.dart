import 'package:firebase_auth_tutorials/auth_services.dart';
import 'package:firebase_auth_tutorials/model_user.dart';
import 'package:firebase_auth_tutorials/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,

          brightness: Brightness.light,
        ),
      ),
    );
  }
}
