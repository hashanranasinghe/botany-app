import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/myheaderdrawer.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DrawerWidget({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: MyHeaderDrawer(),
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
                  Navigator.of(context).pushNamed(AddScreen.routeName);
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

              const ListTile(
                leading:
                    Icon(Icons.delete_outline_outlined, color: Colors.black),
                title: Text(
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
