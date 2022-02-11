
import 'package:botanyapp/models/createAccount.dart';
import 'package:botanyapp/models/googlesignin.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/verificationemailscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
  String? _confirmPassword;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                            onPressed: () {
                              signUp(emailController.text.trim(), passwordController.text.trim());
                            },
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
                          onTap: (){
                            final googleProvider = Provider.of<GoogleSignInProvider>(context,listen: false);
                            googleProvider.googleLogin().whenComplete(() =>
                                Navigator.of(context).pushReplacementNamed(SearchScreen.routeName)

                            );
                          },
                          child: const Image(
                            image: AssetImage('assets/images/google-logo.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ?",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,

                            ),),
                          TextButton(child: const Text(
                            'Log in',
                            // style: TextStyle(color: Color(0xff707070)),
                          ),
                            onPressed: (){
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },)
                        ],
                      ),
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
        controller: usernameController,
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
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.r))),
        validator: (value) {
          return Validator.emailValidate(value!);
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
        controller: passwordController,
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
        validator: (value) {
          return Validator.PasswordValidate(value!);
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
        controller: confirmPasswordController,
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
        validator: (value) {
          if(confirmPasswordController.text !=passwordController.text){
            return "Password do not match.";
          }
          return null;
        },
        onSaved: (String? value) {
          _confirmPassword = value;
        },
      ),
    );
  }
  void signUp(String email, String password) async{
    if(_form.currentState!.validate()){

      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>{
        postDetailsToFileStore()

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }

  }

  postDetailsToFileStore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    CreateAccDetails createAccDetails = CreateAccDetails();
    createAccDetails.userName = usernameController.text;
    createAccDetails.email = user!.email;
    createAccDetails.uid = user.uid;

    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(createAccDetails.toMap());
    Navigator.of(context).pushReplacementNamed(VerificationEmailScreen.routeName);
  }

}

class Validator {
  static String? NameValidate(String value) {
    if (value.isEmpty) {
      return "Name cannot be Empty";
    } else if (!value.contains(RegExp(r'[A-z]'))) {
      return "Invalid Name.";
    } else if (value.length < 3) {
      return "Invalid Name.";
    }
    return null;
  }

  static String? PasswordValidate(String passwordValue) {
    if (passwordValue.isEmpty) {
      return "Password Cannot be Empty";
    } else if (!passwordValue.contains(RegExp(r'[a-zA-Z0-9]'))) {
      return "Invalid Password";
    }else if(passwordValue.length < 6){
      return "Enter valid Password.(Min. 6 characters)";
    }
    return null;
  }

  static String? emailValidate(String emailValue){
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    if (emailValue.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!regExp.hasMatch(emailValue)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }
}

