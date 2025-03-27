import 'package:flutter/material.dart';

class DashedLineVertical extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final double gap;
  final Color color;

  const DashedLineVertical({
    Key? key,
    required this.height,
    this.dashWidth = 1,
    this.dashHeight = 4,
    this.gap = 3,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(dashWidth, height),
      painter: _DashedLinePainter(
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        gap: gap,
        color: color,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashHeight;
  final double gap;
  final Color color;

  _DashedLinePainter({
    required this.dashWidth,
    required this.dashHeight,
    required this.gap,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
