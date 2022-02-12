import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ResetScreen extends StatefulWidget {
  static const routeName = 'reset screen';
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Enter your email'
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins'
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 50),
                        primary: const Color(0xff102248),
                      ),
                      icon: const Icon(Icons.email),
                      label: const Text(
                        'Send email',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      onPressed: (){
                        auth.sendPasswordResetEmail(email: _email);
                        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                        Fluttertoast.showToast(msg: "We will send the email for reset the password.",
                        toastLength: Toast.LENGTH_LONG,);
                      }
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              )
            ],
            ),
          const Align(
              alignment: FractionalOffset.bottomCenter,
              child: WaveWidget()),
          ],
      ),
    );
  }
}