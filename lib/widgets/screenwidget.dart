
import '../screens/myheaderdrawer.dart';
import 'package:flutter/material.dart';

import '../screens/addscreen.dart';

class ScreenWidget extends StatelessWidget {
  Widget child ;
  static const routeName = 'searchScreen';
  ScreenWidget({required this.child});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children:  [
            const DrawerHeader(
                child: MyHeaderDrawer(),
            ),
            _myListDrawer(context),
          ],
        ),
      ),

      body: Column(
        children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton( icon: const Icon(Icons.menu,color: Colors.black),
              onPressed: ()=> _scaffoldKey.currentState?.openDrawer(),
              padding: const EdgeInsets.only(top: 40,left: 20),
              iconSize: 40,),
              SizedBox(
                        height: 100,
                        width: 100,
                        child:Center(child: Image.asset('assets/images/logo_1.png')),
                    ),
              const SizedBox(
                height: 20,
                width: 50,
              )
            ],
          ),
          child
        ],
      ),
      );
  }



  Widget _myListDrawer(BuildContext context){
    return Column(
      children: <Widget>[
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: (){
            Navigator.of(context).pushNamed(AddScreen.routeName);
          },
          ),
          title: const Text('Add',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),
        const Divider(thickness: 2,),

        const ListTile(
          leading: Icon(Icons.update_outlined,color: Colors.black),
          title: Text('Update',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),
        const Divider(thickness: 2,),

        const ListTile(
          leading: const Icon(Icons.delete_outline_outlined,color: Colors.black),
          title: Text('Delete',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),
        const Divider(thickness: 2,)
      ],
    );
  }
}
