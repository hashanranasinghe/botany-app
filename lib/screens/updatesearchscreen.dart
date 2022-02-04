import 'package:botanyapp/screens/bodies/updatesearchbody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateSearchScreen extends StatefulWidget {
  static const routeName = 'Update search screen';
  const UpdateSearchScreen({Key? key}) : super(key: key);

  @override
  _UpdateSearchScreenState createState() => _UpdateSearchScreenState();
}

class _UpdateSearchScreenState extends State<UpdateSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UpdateSearchBody(),
    );
  }
}
