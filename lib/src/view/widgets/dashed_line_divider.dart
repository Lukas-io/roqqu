import 'package:flutter/material.dart';

class DashedLineDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedLineDivider({
    super.key,
    this.height = 1,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        height: height,
      ),
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double height;

  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}
