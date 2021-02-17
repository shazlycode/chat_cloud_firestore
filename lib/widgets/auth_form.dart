import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  String _email = '';
  bool isSigned = true;
  void auth() {
    final validated = _form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (validated) {
      _form.currentState.save();
    } else {
      return;
    }
    print(_userName);
    print(_email);
    print(_password);
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
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _email = value;
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
                        _userName = value;
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
                      _password = value;
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
                  RaisedButton(
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
