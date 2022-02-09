import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DrawerWidget({required this.scaffoldKey});

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
              // ignore: prefer_const_constructors
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AddScreen.routeName);
                },
                leading: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  'Add',
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
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UpdateSearchScreen.routeName);
                },
                leading: const Icon(Icons.update_outlined, color: Colors.black),
                title: Text(
                  'Update',
                  style: TextStyle(
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
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(DeleteSearchScreen.routeName);
                },
                leading: const Icon(Icons.delete_outline_outlined,
                    color: Colors.black),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
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
