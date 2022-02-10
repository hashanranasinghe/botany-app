import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    Key? key,
    required this.size, required this.child,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(child: Image.asset('assets/images/login.jpg')),
          Positioned(
            top: 0,
            child: Container(
              height:200,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
            ),
          ),
          Positioned(
            bottom: 5 ,
            child: SizedBox(
                height: 200, width: 200,child: Image.asset('assets/images/logo_1.png')),),
          child,
        ],
      ),
    );
  }
}
