
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../searchscreen.dart';

class DeleteSearchBody extends StatelessWidget {
  DeleteSearchBody({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: Column(
        children: [
          TopScreenWidget(
              scaffoldKey: _scaffoldKey,
              topLeft: Padding(
                padding: const EdgeInsets.only(top: 30, right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SearchScreen.routeName);
                    },
                    icon: const Icon(Icons.home)),
              )),
          Container(
            padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTopic(),
                _buildSearchBar(),


              ],
            ),
          ),
          const Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: WaveWidget()),
          ),

        ],
      ),
    );
  }

  // Widget _buildSearchfield(){
  //   return Container(
  //     padding: const EdgeInsets.only(top: 20),
  //     child: TextFormField(
  //       textAlign: TextAlign.center,
  //       decoration: InputDecoration(
  //         icon: const Icon(Icons.search),
  //         contentPadding: const EdgeInsets.all(5),
  //         hintStyle: const TextStyle(
  //           fontFamily: 'Poppins',
  //           fontSize: 20,
  //         ),
  //         hintText: "Search",
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
  //       ),
  //     ),
  //     margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
  //   );
  // }
  Widget _buildTopic(){
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: const [
          Icon(
            Icons.delete_outline_outlined,
            color: Colors.black,
          ),
          Text('Delete',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ],
      ),
    );
  }

  Widget _buildSearchBar(){
    return CupertinoSearchTextField(
      prefixInsets: const EdgeInsets.only(left: 20),
      itemSize: 25,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Poppins',
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
    );
  }


}
