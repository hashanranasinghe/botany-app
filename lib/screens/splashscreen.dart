import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_settings/app_settings.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        if (finalEmail == null) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          
        } else {
          Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
         
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
      if (_connectionStatus.toString() == "ConnectivityResult.bluetooth" ||
          _connectionStatus.toString() == "ConnectivityResult.none") {
        connection(context);
      }
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail;
    });
  }

  void connection(BuildContext context) {
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
              width: 250.w,
              child: Image.asset(
                'assets/images/logo_1.png',
              ),
            ),
            // const SizedBox(
            // height: 20,
            // ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
