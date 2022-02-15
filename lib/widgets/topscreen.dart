import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 10.w),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                iconSize: 30.sp,
              ),
            ),
            SizedBox(
              height: 75.h,
              width: 100.w,
              child: Center(child: Image.asset('assets/images/logo_1.png')),
            ),
            topLeft,
            // IconButton(onPressed: () {}, icon: Icon(Icons.home))
          ],
        ),
      ],
    );
  }
}
