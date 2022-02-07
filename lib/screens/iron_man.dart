import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marvel_logos/screens/captain_america.dart';

class IronMan extends StatelessWidget {
  const IronMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: FractionallySizedBox(
        heightFactor: 0.5,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade500, // darker color
                  ),
                  const BoxShadow(
                    color: Color(0xfff1f6fd), // background color
                    spreadRadius: -30.0,
                    blurRadius: 20.0,
                  ),
                  const BoxShadow(
                    color: Colors.white, // background color
                    spreadRadius: -70.0,
                    blurRadius: 20.0,
                  ),
                ],
              ),
            ),
            ClipOval(
              child: ClipPath(
                clipper: StripsClipper(),
                child: Container(color: Colors.black),
              ),
            ),
            Transform.rotate(
              angle: 60 * pi / 180,
              child: ClipOval(
                child: ClipPath(
                  clipper: StripsClipper(),
                  child: Container(color: Colors.black),
                ),
              ),
            ),
            Transform.rotate(
              angle: -60 * pi / 180,
              child: ClipOval(
                child: ClipPath(
                  clipper: StripsClipper(),
                  child: Container(color: Colors.black),
                ),
              ),
            ),
            ClipOval(
              child: CustomPaint(
                  painter: TrianglePainter(),
                  child: Container(color: Colors.transparent)),
            )
          ]),
        ),
      )),
    );
  }
}

class StripsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;

    return Path()
      ..addRect(Rect.fromCenter(
          center: Offset(x / 2, y / 2), width: x, height: 0.15 * y));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var x = size.width;
    var y = size.height;

    final linePaint = Paint();
    linePaint.color = Colors.red;
    linePaint.strokeWidth = 10.0;
    var mag = 100;
    var ang = 60 * pi / 180;
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}
