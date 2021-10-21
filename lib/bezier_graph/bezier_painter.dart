import 'dart:ui';

import 'package:flutter/material.dart';

List<Offset> points1 = [
  Offset(0, -200),
  Offset(30, -400),
  Offset(50, -100),
  Offset(100, -400),
  Offset(200, -500),
  Offset(300, -200),
  Offset(400, -400),
];

double axisVerticalOffset = -50;
double dateTextVerticalOffset = axisVerticalOffset + 10;

class BezierPainter extends CustomPainter {
  BezierPainter(this.dx);

  double dx;
  Paint _dotPaint = Paint();
  Paint _linePaint = Paint();
  Paint _riskIndexPaint = Paint();
  Paint _dateAxisPaint = Paint();
  Path? _bezierPath;// = Path();

  void addCubicBezierPathWithPoints(Path path, List points) {
    Offset prePointOffset;
    Offset currentPointOffset;
    int length = points.length;
    //x轴 两值之间的间距
    // double W = _fixedWidth / (length - 1);
    for (int i = 0; i < length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        prePointOffset = points[i - 1];
        currentPointOffset = points[i];
        double controlPointX1 = (prePointOffset.dx + currentPointOffset.dx) / 2;
        double controlPointY1 = prePointOffset.dy;
        double controlPointX2 = controlPointX1;
        double controlPointY2 = currentPointOffset.dy;
        path.cubicTo(
          controlPointX1,
          controlPointY1,
          controlPointX2,
          controlPointY2,
          currentPointOffset.dx,
          currentPointOffset.dy,
        );
      }
    }
  }

  void addBezierPathWithPoints(Path path, List points) {
    for (int i = 0; i < points.length - 1; i++) {
      Offset current = points[i];
      Offset next = points[i + 1];
      if (i == 0) {
        path.moveTo(current.dx, current.dy);

        double ctrlX = current.dx + (next.dx - current.dx) / 2;
        double ctrlY = next.dy;
        path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      } else if (i < points.length - 2) {
        double ctrl1X = current.dx + (next.dx - current.dx) / 2;
        double ctrl1Y = current.dy;

        double ctrl2X = ctrl1X;
        double ctrl2Y = next.dy;
        path.cubicTo(ctrl1X, ctrl1Y, ctrl2X, ctrl2Y, next.dx, next.dy);
      } else {
        path.moveTo(current.dx, current.dy);

        double ctrlX = current.dx + (next.dx - current.dx) / 2;
        double ctrlY = current.dy;
        path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);

        path.moveTo(next.dx, next.dy);
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _linePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;
    canvas.translate(0, size.height);

    ///generate bezierGraph
    _bezierPath = Path();
    addCubicBezierPathWithPoints(_bezierPath!, points1);

    /// shadow
    var shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp,
            colors: [Colors.orange.withOpacity(0.8), Colors.orangeAccent.withOpacity(0.5)])
        .createShader(Rect.fromLTRB(0, 10, 0, 10));

    Path shadowPath = Path.from(_bezierPath!);
    // shadowPath.moveTo(points1[0].dx, points1[0].dy);
    shadowPath
      ..lineTo(points1[6].dx, axisVerticalOffset)
      ..lineTo(points1[0].dx, axisVerticalOffset)
      ..close();
      // ..lineTo(points1[0].dx, points1[0].dy);
    Path shadowBorderPath = Path.from(shadowPath);
    canvas
      ..drawPath(
          shadowPath,
          Paint()
            ..shader = shader
            ..isAntiAlias = true
            ..style = PaintingStyle.fill
      )
      ..drawPath(
          shadowBorderPath,
          Paint()
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
        ..color = Colors.blue
        ..strokeWidth = 10
      )
      ..drawPath(_bezierPath!, _linePaint);

    /// dateAxis
    _drawDateAxis(canvas, size);

    ///riskIndex
    canvas.drawLine(Offset(dx, -300), Offset(dx, 0), _linePaint);
  }

  void _drawDateAxis(
    Canvas canvas,
    Size size,
  ) {
    canvas.drawLine(
      Offset(0, axisVerticalOffset),
      Offset(size.width, axisVerticalOffset),
      _linePaint,
    );
    for (int i = 0; i < points1.length; i++) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '09/0$i',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(points1[i].dx, dateTextVerticalOffset));
    }
  }

  @override
  bool shouldRepaint(BezierPainter oldDelegate) {
    return true;
  }
}
