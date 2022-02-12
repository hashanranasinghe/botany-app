import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    Key? key,
    required this.size,
    required this.child,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      // width: double.infinity,
      //height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(child: Image.asset('assets/images/login.jpg')),
          Positioned(
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r))),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Image.asset('assets/images/logo_1.png')),
          ),
          child,
        ],
      ),
    );
  }
}
