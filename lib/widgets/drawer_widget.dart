import 'package:botanyapp/screens/addscreen.dart';
import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/loginscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:botanyapp/widgets/drawer_widget_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DrawerWidget({required this.scaffoldKey});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValidationData().whenComplete(() async{

      if(finalEmail == null){

      }else{

      }

    });


  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail  =obtainEmail;
    });
  }



  @override
  Widget build(BuildContext context) => finalEmail!= "zillion.shopper@gmail.com"
      ? const DrawerWidgetUser()
      : Drawer(
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
              const Padding(padding: EdgeInsets.only(top: 0.3)),
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
