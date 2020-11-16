import 'package:flutter/material.dart';
import 'dart:math';

class ProfileCardPainter extends CustomPainter {
  final Color color;
  final double avatarRadius;

  ProfileCardPainter({@required this.color, this.avatarRadius});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final shapeBounds =
        Rect.fromLTWH(0, 0, size.width, size.height - avatarRadius);
    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final avatarBounds =
        Rect.fromCircle(center: centerAvatar, radius: avatarRadius).inflate(6);
    _drawBackground(canvas, shapeBounds, avatarBounds);
  }

  void _drawBackground(Canvas canvas, Rect shapeBounds, Rect avatarBounds) {
    final paint = Paint()..color = color;
    final backgroundPath = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top) //3
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy) //4
      ..arcTo(avatarBounds, -pi, pi, false) //5
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottomRight.dy) //6
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy) //7
      ..close(); //8
    canvas.drawPath(backgroundPath, paint);
  }

  @override
  bool shouldRepaint(ProfileCardPainter oldDelegate) =>
      color != oldDelegate.color;

  @override
  bool shouldRebuildSemantics(ProfileCardPainter oldDelegate) => false;
}
