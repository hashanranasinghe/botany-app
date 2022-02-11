import 'package:botanyapp/screens/bodies/updatebody.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  static const routeName = 'Update screen';
  UpdateScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: UpdateBody(
          scaffoldKey: _scaffoldKey,
          id: productId,
        ),
      ),
    );
  }
}
