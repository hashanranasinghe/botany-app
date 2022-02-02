import 'package:botanyapp/screens/bodies/deletesearchbody.dart';
import 'package:flutter/material.dart';

class DeleteSearchScreen extends StatefulWidget {
  static const routeName = 'Delete screen';
  const DeleteSearchScreen({Key? key}) : super(key: key);

  @override
  _DeleteSearchScreenState createState() => _DeleteSearchScreenState();
}

class _DeleteSearchScreenState extends State<DeleteSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DeleteSearchBody(),
    );
  }
}
