import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static const routeName = 'Details screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  var count;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    var wordlist = Provider.of<Words>(context);

        FirebaseFirestore db = FirebaseFirestore.instance;
        db.collection("users").get().then((value) =>  count= (value.size - 1));






      return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(


        child: Stack(
          children: [
            Column(
              children: [
                TopScreenWidget(
                    scaffoldKey: _scaffoldKey,
                    topLeft: SizedBox(
                      height: 50.h,
                      width: 50.w,
                    )),
                SizedBox(
                  height: 50.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    SizedBox(
                      width: 300,
                      child: Text('The number of words currently in the app ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                        ),),
                    ),
                    Text('=',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                      ),),
                    Text(wordlist.wordslist.length.toString(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
                    ),),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    SizedBox(
                      width: 300,
                      child: Text('The number of users currently using the app ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                        ),),
                    ),
                    Text('=',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                      ),),
                    Text(count.toString(),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                  ],
                ),
              ],
            ),
            const Align(
                alignment: FractionalOffset.bottomCenter,
                child: WaveWidget()),
          ],
        ),
      ),

    );
  }
}
