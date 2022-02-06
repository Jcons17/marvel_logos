import 'dart:math' as math;
import 'package:flutter/material.dart';

const red = Color(0xFFc33124);

class CaptainAmerica extends StatelessWidget {
  const CaptainAmerica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: AspectRatio(aspectRatio: 1, child: CaptainAmericaLogo()),
        ),
      ),
    );
  }
}

class CaptainAmericaLogo extends StatelessWidget {
  const CaptainAmericaLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              // color: Colors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: red.withOpacity(0.5),
                    spreadRadius: 30,
                    //blurStyle: BlurStyle.outer,
                    blurRadius: 50)
              ]),
        ),
        ClipOval(
          child: Transform.scale(
            scale: 2,
            child: CustomPaint(
              painter: MetalPainter(),
              child: Container(
                color: red.withOpacity(0.7),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.85,
          widthFactor: 0.85,
          child: ClipOval(
            child: CustomPaint(
              painter: MetalPainter(),
              child: Container(color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.7,
          widthFactor: 0.7,
          child: ClipOval(
            child: Transform.scale(
              scale: 2,
              child: CustomPaint(
                painter: MetalPainter(),
                child: Container(color: red.withOpacity(0.6)),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.50,
          widthFactor: 0.50,
          child: ClipOval(
            child: Transform.scale(
              scale: 2,
              child: CustomPaint(
                painter: MetalPainter(fillColor: const Color(0xff0e4591)),
                child:
                    Container(color: const Color(0xff0e4591).withOpacity(0.6)),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.50,
          widthFactor: 0.50,
          child: Transform.rotate(
            angle: 198 * math.pi / 180,
            child: ClipPath(
              clipper: StarClipper(5),
              child: CustomPaint(
                painter: MetalPainter(
                    fillColor: Colors.grey.shade100.withOpacity(0.5)),
                child: Container(color: Colors.grey.shade100.withOpacity(0.5)),
              ),
            ),
          ),
        ),
        ClipOval(
          child: CustomPaint(
            painter: _ClipShadowShadowPainter(
                shadow: Shadow(
                    blurRadius: 30, color: Colors.white.withOpacity(0.5)),
                clipper: ShadowClipper()),
            child: ClipPath(
              clipper: ShadowClipper(),
              child: Container(
                  //color: Colors.white.withOpacity(0.0),
                  ),
            ),
          ),
        ),
        ClipOval(
          child: Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: _ClipShadowShadowPainter(
                  shadow: Shadow(
                      blurRadius: 30, color: Colors.white.withOpacity(0.2)),
                  clipper: ShadowClipper()),
              child: ClipPath(
                clipper: ShadowClipper(),
                child: Container(
                    //color: Colors.white.withOpacity(1),
                    ),
              ),
            ),
          ),
        ),
        ClipOval(
          child: Transform.rotate(
            angle: math.pi / 2,
            child: CustomPaint(
              painter: _ClipShadowShadowPainter(
                  shadow: Shadow(
                      blurRadius: 30, color: Colors.black.withOpacity(0.4)),
                  clipper: ShadowClipper()),
              child: ClipPath(
                clipper: ShadowClipper(),
                child: Container(
                    //color: Colors.white.withOpacity(0.0),
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  /// The number of points of the star
  final int points;
  StarClipper(this.points);

  // Degrees to radians conversion
  double _degreeToRadian(double deg) => deg * (math.pi / 180.0);

  @override
  Path getClip(Size size) {
    Path path = Path();
    double max = 2 * math.pi;

    double width = size.width;
    double halfWidth = width / 2;

    double wingRadius = halfWidth;
    double radius = halfWidth / 2;

    double degreesPerStep = _degreeToRadian(360 / points);
    double halfDegreesPerStep = degreesPerStep / 2;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + wingRadius * math.cos(step),
          halfWidth + wingRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  // If the new instance represents different information than the old instance, this method will return true, otherwise it should return false.
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper starClipper = oldClipper as StarClipper;
    return points != starClipper.points;
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;

    return Path()
      ..moveTo(0.3 * x, 0)
      ..quadraticBezierTo(0.5 * x, 0.5 * y, 0.4 * x, y)
      ..lineTo(0.7 * x, y)
      ..quadraticBezierTo(0.5 * x, 0.5 * y, 0.6 * x, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MetalPainter extends CustomPainter {
  final linePaint = Paint()..color = Colors.white12.withOpacity(0.03);

  final double density;
  final Color fillColor;

  /// Expose to outside, allowing to override default value
  MetalPainter({this.density = .05, this.fillColor = red});

  // ...
  static final rnd = math.Random();

  static Offset randomOffset(Size size) {
    return Offset(
        rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = fillColor;

    // This [Rect] will fill the whole canvas we got
    var fillRect = Rect.fromPoints(Offset.zero, size.bottomRight(Offset.zero));
    var count = fillRect.width * fillRect.height * density;

    canvas.drawRect(
      fillRect,
      fillPaint,
    );
    for (var i = 0; i < count; i++) {
      canvas.drawLine(randomOffset(size), randomOffset(size), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  _ClipShadowShadowPainter({required this.shadow, required this.clipper});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
