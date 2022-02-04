import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/singpupage.dart';
import 'package:botanyapp/screens/splashscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp()

  //   DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(), // Wrap your app
  // ),
  runApp(
    const MyApp(),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routName: (ctx) => const SplashScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        AddScreen.routeName: (ctx) => AddScreen(),
        DeleteSearchScreen.routeName: (ctx) => const DeleteSearchScreen(),
        UpdateSearchScreen.routeName: (ctx) => const UpdateSearchScreen(),
        UpdateScreen.routeName: (ctx) => UpdateScreen(),
      },
    );
  }
}
