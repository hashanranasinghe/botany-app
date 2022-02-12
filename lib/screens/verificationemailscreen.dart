import 'dart:async';

import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
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
  bool canResendEmail =false;
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

      setState(() =>canResendEmail =false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);


    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerify
      ? SearchScreen()
      :Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                const Text("A verification email has sent to your email.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,

                ),),
              const Text("Please verify",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ElevatedButton.icon(


                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      primary: const Color(0xff102248),



                    ),
                icon: const Icon(Icons.email),
                label: const Text(
                  'Resend email',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,

                  ),
                ),
                onPressed: (){
                      if(canResendEmail){
                        sendVerificationEmail();
                      }
                }
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                  child: TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Color(0xff102248),
                        ),
                      ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xffc6c9cd)),
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut()

                      ),
                ),
              ]
          ),
          const Align(
              alignment: FractionalOffset.bottomCenter,
              child: WaveWidget()),
        ],
      ),
    );
}
