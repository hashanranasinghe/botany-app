import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
// <<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// =======
// >>>>>>> refs/remotes/origin/master
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_settings/app_settings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

// <<<<<<< HEAD
// =======
  late WebViewController _webViewController;

// >>>>>>> refs/remotes/origin/master
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getValidationData().whenComplete(() async {
// <<<<<<< HEAD
      Timer(const Duration(seconds: 2), () {
        if (finalEmail == null) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);

// =======
//       Timer(const Duration(seconds: 3), () {
//         if (_connectionStatus.toString() == "ConnectivityResult.bluetooth" ||
//             _connectionStatus.toString() == "ConnectivityResult.none") {
//           connection(context);
//         } else if (finalEmail == null) {
//           Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
//         } else {
//           Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
// >>>>>>> refs/remotes/origin/master
        }
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn \'t check connectivity status');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
// <<<<<<< HEAD
      if (_connectionStatus.toString() == "ConnectivityResult.bluetooth" ||
          _connectionStatus.toString() == "ConnectivityResult.none") {
        connection(context);
      }
// =======
// >>>>>>> refs/remotes/origin/master
    });
  }

  Future getValidationData() async {
// <<<<<<< HEAD
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
// =======
//     final SharedPreferences sharedPreferences = await SharedPreferences
//         .getInstance();
// >>>>>>> refs/remotes/origin/master
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail;
    });
  }

  void connection(BuildContext context) {
// <<<<<<< HEAD
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    AppSettings.openDataRoamingSettings();
                  },
                ),
// =======
//     showCupertinoDialog(context: context,
//         builder: (context) =>
//             CupertinoAlertDialog(
//               content: Text('No Internet Connection',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 15.sp,
//                 ),),
//               actions: [
//                 CupertinoDialogAction(
//                   child: Text('Ok',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 15.sp,
//                     ),),
//                   onPressed: () {
//                     setState(() {
//                       Navigator.of(context).pushReplacementNamed(
//                           SplashScreen.routName);
//                     });
//                   },),
//                 CupertinoDialogAction(
//                   child: const Text('Settings',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20,
//                     ),),
//                   onPressed: () {
//                     AppSettings.openWIFISettings();
//                   },),

// >>>>>>> refs/remotes/origin/master
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            SizedBox(
// <<<<<<< HEAD
              width: 250.w,
// =======
//               height: 200.h,
//               width: 200.w,
// >>>>>>> refs/remotes/origin/master
              child: Image.asset(
                'assets/images/logo_1.png',
              ),
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
// <<<<<<< HEAD
// =======

//   // @override
//   // Widget build(BuildContext context) {
//   //   // TODO: implement build
//   //   throw UnimplementedError();
//   // }
// >>>>>>> refs/remotes/origin/master
}
