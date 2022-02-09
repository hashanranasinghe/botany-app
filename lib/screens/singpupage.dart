import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Image(
          image: AssetImage('assets/images/signup.jpg'),
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
                        margin: EdgeInsets.only(
                            left: 40.w, top: 10.h, bottom: 10.h),
                        child: Text(
                          "Sign-Up",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 40.sp,
                          ),
                        ),
                      ),
                      _buildUsername(),
                      _buildEmail(),
                      _buildPassword(),
                      _buildConfirmPassword(),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 40.w),
                        child: TextButton(
                            onPressed: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 6.w),
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
                                  borderRadius: BorderRadius.circular(27.r),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff102248)))),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
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
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 35.h,
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
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
      child: TextFormField(
        autofocus: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            hintText: "Username",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.r))),
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
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.r))),
        validator: (String? value) {
          const Pattern =
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
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
      child: TextFormField(
        obscureText: !_passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
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
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
      child: TextFormField(
        obscureText: !_confirmPasswordVisible,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
          suffixIcon: IconButton(
            icon: Icon(_confirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
        ),
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
