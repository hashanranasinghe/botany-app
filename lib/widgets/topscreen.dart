import 'package:flutter/material.dart';

class TopScreenWidget extends StatelessWidget {
  const TopScreenWidget(
      {Key? key,
      required GlobalKey<ScaffoldState> scaffoldKey,
      required this.topLeft})
      : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  final Widget topLeft;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                iconSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(child: Image.asset('assets/images/logo_1.png')),
              ),
            ),
            topLeft

            // IconButton(onPressed: () {}, icon: Icon(Icons.home))
          ],
        ),
      ],
    );
  }
}
