import 'package:botanyapp/widgets/screenwidget.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatelessWidget {

  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = 'Search screen';

  @override
  Widget build(BuildContext context) {

    return ScreenWidget(
        child: const Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: WaveWidget())),
      );
  }
}
