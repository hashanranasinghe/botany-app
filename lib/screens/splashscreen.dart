import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/singpupage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Center(
          child: Container(
            height: 300,
            width: 200,
            child: Image.asset(
              'assets/images/logo_1.png',
            ),
          ),
        ),
        nextScreen: SearchScreen(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
