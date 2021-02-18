import 'package:chat_cloud_firestore/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _authenticateForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    final firebaseAuth = FirebaseAuth.instance;
    print(email);
    try {
      if (!isLogin) {
        final authResult = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        final authResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (e) {
      print('Errrrrrrrrrrrrrrrrrror' + e.toString());
      var message = 'an error occured, try again later';
      if (e.message != null) {
        message = e.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      // throw PlatformException(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_authenticateForm),
    );
  }
}
