import 'package:flutter/material.dart';

class DropletPainter extends CustomPainter {
  const DropletPainter({
    this.fillColor = const Color.fromRGBO(84, 116, 129, 1),
    this.isLeftSided = true,
  });
  final Color fillColor;
  final bool isLeftSided;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width, size.height * 0.579);
    path.cubicTo(
        size.width, size.height * 0.8,
        size.width * 0.29, size.height * 0.73,
        0, size.height
    );
    path.lineTo(0, 0);
    path.cubicTo(
        size.width * 0.12, size.height * 0.366,
        size.width, size.height * 0.356,
        size.width, size.height * 0.579
    );

    var matrix4 = Matrix4.identity();
    matrix4.scale(isLeftSided ? 1.0 : -1.0, 1.0);
    matrix4.translate(isLeftSided ? 0.0 : -size.width);

    path = path.transform(matrix4.storage);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
