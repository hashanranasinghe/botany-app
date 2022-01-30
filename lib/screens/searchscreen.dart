import 'package:botanyapp/screens/myheaderdrawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Center(
        child: Text(
          "search"
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              MyHeaderDrawer(),
              _myListDrawer(),
            ),
          ),
        ),
      ),
    );

  }
  Widget _myListDrawer(){
    return Container();
  }
}
