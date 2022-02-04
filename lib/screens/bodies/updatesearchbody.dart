import 'package:botanyapp/widgets/screenwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateSearchBody extends StatefulWidget {
  const UpdateSearchBody({Key? key}) : super(key: key);

  @override
  _UpdateSearchBodyState createState() => _UpdateSearchBodyState();
}

class _UpdateSearchBodyState extends State<UpdateSearchBody> {

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
            Icons.update_outlined,
            color: Colors.black,
          ),
          Text('Update',
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

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      child: Container(
        padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTopic(),
            _buildSearchBar(),
          ],
        ),
      ),
    );
  }
}
