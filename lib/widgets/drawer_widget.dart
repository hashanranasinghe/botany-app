import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              Padding(padding: EdgeInsets.only(top: height * 0.3)),
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
