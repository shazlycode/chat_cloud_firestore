import 'package:chat_cloud_firestore/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  void _authenticateForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    final firebaseAuth = FirebaseAuth.instance;
    print(email);
    try {
      setState(() {
        _isLoading = true;
      });
      if (!isLogin) {
        final authResult = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({'username': username, 'email': email});
        setState(() {
          _isLoading = false;
        });
      } else {
        final authResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
      body: AuthForm(_authenticateForm, _isLoading),
    );
  }
}
