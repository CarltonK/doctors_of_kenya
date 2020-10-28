import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final Color color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final backgroundBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final paintBackground = Paint()..color = color;
    canvas.drawRect(backgroundBounds, paintBackground);

    // Foreground
    final pathBounds = Path()
      ..moveTo(0, size.height * 0.9167)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.875,
          size.width * 0.5, size.height * 0.9167)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
          size.width * 1.0, size.height * 0.9167)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paintForeground = Paint()
      ..color = Colors.orange[600]
      ..style = PaintingStyle.fill;

    canvas.drawPath(pathBounds, paintForeground);

    // Circle
    final circleBounds = Offset(size.width / 2, size.height / 2);
    final circlePaint = Paint()..color = Colors.orange[400];
    canvas.drawCircle(circleBounds, 90, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundPainter oldDelegate) => false;
}
