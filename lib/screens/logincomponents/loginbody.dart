import 'package:botanyapp/screens/resetscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../singpupscreen.dart';
import 'loginbackground.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _userName;
  String? _password;
  bool _passwordVisible = false;
  final _auth = FirebaseAuth.instance;

  Widget _buildUsernameField() {
    return Container(
      child: TextFormField(
        maxLength: 50,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (text) {
          return Validator.NameValidate(text!);
        },
        onSaved: (text) {
          _userName = text;
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
          ),
          hintText: "User email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      child: TextFormField(
        maxLength: 8,
        maxLines: 1,
        controller: passwordController,
        textInputAction: TextInputAction.done,
        validator: (text) {
          return Validator.PasswordValidate(text!);
        },
        onSaved: (text) {
          _password = text;
        },
        obscureText: !_passwordVisible,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
          ),
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
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
      child: TextButton(
        onPressed: () async {
          signIn(emailController.text, passwordController.text);
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', emailController.text);
        },
        child: Text(
          "Login".toUpperCase(),
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: LoginBackground(
          size: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 320.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              _buildUsernameField(),
              _buildPasswordField(),
              _buildLoginButton(),
              _buildForgetPassword(context),
              _buildCreateAccount(context),
              Container(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context)
                    .pushReplacementNamed(SearchScreen.routeName),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: 'Incorrect Email or Password.',
        toastLength: Toast.LENGTH_LONG
        );
      });
    }
  }
}

Widget _buildForgetPassword(BuildContext context) {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 40.w),
    child: TextButton(
      child: Text(
        'Forget your Password?',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15.sp,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(ResetScreen.routeName);
      },
    ),
  );
}

Widget _buildCreateAccount(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(right: 40.w),
    height: 40.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Text("Don't have an account? "),
        TextButton(
          child: const Text('Create'),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
          },
        ),
      ],
    ),
  );
}

class Validator {
  static String? NameValidate(String value) {
    if (value.isEmpty) {
      return "Name cannot be Empty";
    } else if (!value.contains(RegExp(r'[A-z]'))) {
      return "Invalid Name.";
    } else if (value.length < 5) {
      return "Invalid Name.";
    }
    return null;
  }

  static String? PasswordValidate(String passwordValue) {
    RegExp regex =
    RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$');
    if (passwordValue.isEmpty) {
      return "Password Cannot be Empty";
    } else if (!regex.hasMatch(passwordValue)) {
      return "Invalid Password";
    }else if(passwordValue.length < 6){
      return "Enter valid Password.(Min. 6 characters)";
    }
    return null;
  }

}
