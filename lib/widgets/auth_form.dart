import 'dart:io';

import 'package:chat_cloud_firestore/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password, String userName, File image,
      bool isLogin, BuildContext ctx) authFn;
  bool isLoading;
  AuthForm(this.authFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  bool isSigned = true;
  File image;

  void pickImage(File img) {
    image = img;
  }

  void auth() {
    final validated = _form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isSigned && image == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Take your profile picture first')));
      return;
    }
    if (validated) {
      _form.currentState.save();

      widget.authFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          image, isSigned, context);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isSigned) UserImagePicker(pickImage),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      setState(() {
                        _userEmail = value;
                      });
                    },
                    validator: (value) {
                      if (!value.contains('@') || value.isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  if (!isSigned)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (value) {
                        setState(() {
                          _userName = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a valid username';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Enter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      setState(() {
                        _userPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: () {
                            auth();
                          },
                          child: !isSigned ? Text('SignUp') : Text('Login'),
                        ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        isSigned = !isSigned;
                      });
                    },
                    child: !isSigned
                        ? Text('Already have account, SignIn')
                        : Text('Create new account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
