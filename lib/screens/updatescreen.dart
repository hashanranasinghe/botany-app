import 'package:botanyapp/screens/bodies/updatebody.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {

  static const routeName = 'Update screen';
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UpdateBody(),
    );
  }
}
