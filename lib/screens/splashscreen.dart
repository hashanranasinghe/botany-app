import 'dart:async';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
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

  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        if (_connectionStatus.toString() == "ConnectivityResult.bluetooth" ||
            _connectionStatus.toString() == "ConnectivityResult.none") {
          connection(context);
        } else if (finalEmail == null) {
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
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail;
    });
  }

  void connection(BuildContext context) {
    showCupertinoDialog(context: context,
        builder: (context) =>
            CupertinoAlertDialog(
              content: Text('No Internet Connection',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                ),),
              actions: [
                CupertinoDialogAction(
                  child: Text('Ok',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                    ),),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushReplacementNamed(
                          SplashScreen.routName);
                    });
                  },),
                CupertinoDialogAction(
                  child: const Text('Settings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),),
                  onPressed: () {
                    AppSettings.openWIFISettings();
                  },),

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
              height: 200.h,
              width: 200.w,
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

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
}
