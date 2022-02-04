import 'package:botanyapp/screens/searchscreen.dart';
import 'package:flutter/material.dart';
import 'loginbackground.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _userName;
  String? _password;
  bool _passwordVisible = false;

  Widget _buildUsernameField() {
    return Container(
      child: TextFormField(
        maxLength: 50,
        validator: (text) {
          return Validator.NameValidate(text!);
        },
        onSaved: (text) {
          _userName = text;
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "UserName",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      child: TextFormField(
        maxLength: 8,
        maxLines: 1,
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
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            print(_userName);
            Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
          }
        },
        child: Text(
          "Login".toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
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
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              _buildUsernameField(),
              _buildPasswordField(),
              _buildLoginButton(),
              _buildForgetPassword(),
              _buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildForgetPassword() {
  return Container(
    alignment: Alignment.bottomRight,
    padding: const EdgeInsets.only(right: 40),
    child: const Text(
      'Forget your Password?',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10,
      ),
    ),
  );
}

Widget _buildCreateAccount() {
  return Container(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text("Don't have an account? "),
        Text("Create"),
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
    if (passwordValue.isEmpty) {
      return "Password Cannot be Empty";
    } else if (!passwordValue.contains(RegExp(r'[a-zA-Z0-9]'))) {
      return "Invalid Password";
    }
    return null;
  }
}
