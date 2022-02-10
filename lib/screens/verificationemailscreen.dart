import 'dart:async';

import 'package:botanyapp/screens/searchscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerificationEmailScreen extends StatefulWidget {
  const VerificationEmailScreen({Key? key}) : super(key: key);
  static const routeName = 'verification email';

  @override
  State<VerificationEmailScreen> createState() => _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {

  Timer? timer;
  bool isEmailVerify = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerify =FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerify){
      sendVerificationEmail();

        timer = Timer.periodic(const Duration(seconds: 5), (_)=>
          checkEmailVerify(),

        );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  Future checkEmailVerify() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {


      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerify) timer?.cancel();
  }
  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }




  @override
  Widget build(BuildContext context) => isEmailVerify
      ? SearchScreen()
      :const Scaffold(
      body: Center(
        child: Text("An email has sent . Please verify"),
      ),
    );





}
