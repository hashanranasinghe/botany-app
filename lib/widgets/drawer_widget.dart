import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/menu.jpg'),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Column(
            children: <Widget>[
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
                title: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
                title: const Text(
                  'Update',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
                title: const Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
                        height: 150,
                        width: 150,
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
