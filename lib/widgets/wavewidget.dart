import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  const WaveWidget({Key? key}) : super(key: key);

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> {
  @override
  Widget build(BuildContext context) {
      return RotatedBox(
        quarterTurns: 2,
        child: Stack(
          children: [
            Opacity(opacity: 0.5,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0Xff00bdff),
                height: 200,
              ),
            ),),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: const Color(0Xff2a74dd),
            height: 170,
          ),
        ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0Xff012766),
                height: 140,
              ),
            ),
          ],
        ),
      );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height - 50);
    //first magnet
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //Second magnet
    var secondControlPoint = Offset(size.width * 0.75, size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}