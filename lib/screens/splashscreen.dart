import 'dart:async';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const SearchScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // logo here
        Image.asset(
        'assets/images/logo_1.png',
    ),
    // const SizedBox(
    // height: 20,
    // ),
    const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    )
    ],
    ),
    ),
    );
  }
}




