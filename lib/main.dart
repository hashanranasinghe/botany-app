import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/widgets/screenwidget.dart';
import 'package:botanyapp/screens/singpupage.dart';
import 'package:botanyapp/screens/splashscreen.dart';
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
        SplashScreen.routName: (ctx) => SplashScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        AddScreen.routeName: (ctx) => AddScreen(),
      },
    );
  }
}
