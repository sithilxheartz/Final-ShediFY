import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tutorials/models/user_model.dart';
import 'package:flutter/animation.dart';

class AuthteServices {
  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create a user from firebase with uid
  Usermodel? _userwithFirebaseUserUid(User? user) {
    return user != null ? Usermodel(uid: user.uid) : null;
  }

  // create the stream for checking the auth changes in the user
  Stream<Usermodel?> get user {
    return _auth.authStateChanges().map(_userwithFirebaseUserUid);
  }

  // sign in anonymous
  Future siginAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userwithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // register using email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userwithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // login using email & pass
  Future loginusingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userwithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // login using gmail
  // logout
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
