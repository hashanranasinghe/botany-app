import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = 'search_screen';
  SearchScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: Column(
        children: [
          TopScreenWidget(
              scaffoldKey: _scaffoldKey,
              topLeft: const SizedBox(
                height: 50,
                width: 50,
              )),

        const Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: WaveWidget())),
        ],
      ),
    );
  }
}
