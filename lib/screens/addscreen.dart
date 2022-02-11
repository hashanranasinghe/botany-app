import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import 'bodies/addbody.dart';

class AddScreen extends StatelessWidget {
  static const routeName = 'Add screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: AddBody(
          scaffoldKey: _scaffoldKey,
        ),
      ),
    );
  }
}
