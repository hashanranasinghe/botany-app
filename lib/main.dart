import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/singpupage.dart';
import 'package:botanyapp/screens/splashscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import 'models/googlesignin.dart';
import 'screens/resetscreen.dart';
import 'screens/verificationemailscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Words(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GoogleSignInProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          routes: {
            SplashScreen.routName: (ctx) => const SplashScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            SignUpScreen.routeName: (ctx) => const SignUpScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            AddScreen.routeName: (ctx) => AddScreen(),
            DeleteSearchScreen.routeName: (ctx) => const DeleteSearchScreen(),
            UpdateSearchScreen.routeName: (ctx) => const UpdateSearchScreen(),
            UpdateScreen.routeName: (ctx) => UpdateScreen(),
            VerificationEmailScreen.routeName: (ctx) => const VerificationEmailScreen(),
            ResetScreen.routeName : (ctx) => ResetScreen(),
          },
        ),
        designSize: const Size(428, 800),
      ),
    );
  }
}
