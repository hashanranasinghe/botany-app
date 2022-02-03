import 'package:botanyapp/screens/deletesearchscreen.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:flutter/material.dart';
import '../screens/addscreen.dart';

class ScreenWidget extends StatelessWidget {
  Widget child ;
  static const routeName = 'searchScreen';
  ScreenWidget({Key? key, required this.child}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children:  [
             DrawerHeader(
                 child: Container(
                   width: double.infinity,
                   height: 300,
                   decoration: const BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage(
                             'assets/images/menu.jpg'),
                         fit: BoxFit.fill,
                       )
                   ),
                 ),
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
              padding: const EdgeInsets.only(top: 40),
              iconSize: 40,),
              Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.only(top: 20),
                        child:Center(child: Image.asset('assets/images/logo_1.png')),
                    ),
              IconButton(icon: const Icon(Icons.home,color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
              },
              padding: const EdgeInsets.only(top: 40),
              iconSize: 40,)
            ],
          ),
          child
        ],
      ),
      );
  }



  Widget _myListDrawer(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        ListTile(
          onTap: (){
            Navigator.of(context).pushNamed(AddScreen.routeName);
          },
          leading: const Icon(Icons.update_outlined,color: Colors.black),
          title: const Text('Add',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),

        const Divider(thickness: 2,),

        ListTile(
          onTap: (){
            Navigator.of(context).pushNamed(UpdateSearchScreen.routeName);
          },
          leading:  const Icon(Icons.update_outlined,color: Colors.black),
          title: const Text('Update',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),

        const Divider(thickness: 2,),

        ListTile(
          onTap: (){
            Navigator.of(context).pushNamed(DeleteSearchScreen.routeName);
          },
          leading: const Icon(Icons.delete_outline_outlined,color: Colors.black),
          title: const Text('Delete',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),

        const Divider(thickness: 2),

        Padding(padding: EdgeInsets.only(top: height* 0.35)),
        Positioned(
          child: SizedBox(
              height: 150, width: 150,child: Image.asset('assets/images/logo_1.png')),),

      ],
    );
  }
}
