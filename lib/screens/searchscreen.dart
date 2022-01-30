import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = 'searchScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'laththa',
        style: TextStyle(
          fontSize: 50,
        ),
      )),
    );
  }
}
