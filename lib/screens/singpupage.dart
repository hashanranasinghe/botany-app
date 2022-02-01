import 'dart:ffi';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = 'Signup screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _userName;
  String? _email;
  String? _password;
  String? _confirmEmail;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Image(
            image: AssetImage('assets/images/signup.jpg'),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
                key: _form,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                            left: 40, top: 10, bottom: 10),
                        child: const Text(
                          "Sign-Up",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                      _buildUsername(),
                      _buildEmail(),
                      _buildPassword(),
                      _buildConfirmPassword(),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 40),
                        child: TextButton(
                            onPressed: () {},
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  'SIGN UP',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff102248)))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Expanded(
                                child: Divider(
                              color: Color(0xff707070),
                              thickness: 3,
                            )),
                            Text(
                              '    or sign up with    ',
                              style: TextStyle(color: Color(0xff707070)),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xff707070),
                                thickness: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 35,
                        child: GestureDetector(
                          child: const Image(
                            image: AssetImage('assets/images/google-logo.png'),
                          ),
                        ),
                      )
                    ])),
          ),
        ),
      ],
    ));
  }

  Widget _buildUsername() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: "Username",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Username can\'t be null';
          }
        },
        onSaved: (String? value) {
          _userName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (String? value) {
          final Pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          final regExp = RegExp(Pattern);
          if (value!.isEmpty) {
            return 'Email can\'t be empty';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        onSaved: (String? value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Password can\'t be empty';
          }
        },
        onSaved: (String? value) {
          _password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: "Comfirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Pleace confirm password';
          }
        },
        onSaved: (String? value) {
          _confirmEmail = value;
        },
      ),
    );
  }
}
