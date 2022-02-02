import 'package:flutter/material.dart';

import 'bodies/addbody.dart';

class AddScreen extends StatelessWidget {

  static const routeName = 'Add screen';
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddBody(),
    );
  }
}
