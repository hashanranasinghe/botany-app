import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidgetUser extends StatelessWidget {
  const DrawerWidgetUser({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/menu.jpg'),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SearchScreen.routeName);
                },
                leading: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              ListTile(
                onTap: () async {
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                leading: const Icon(Icons.logout_outlined,
                    color: Colors.black),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: height * 0.2)),
              Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                        height: 150.h,
                        width: 150.w,
                        child: Image.asset('assets/images/logo_1.png')),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
