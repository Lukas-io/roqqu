import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PriceChartPainter extends CustomPainter {
  final List<double> prices;
  final Color lineColor;
  final Color gradientColor;
  final double gradientOpacity;

  const PriceChartPainter({
    required this.prices,
    required this.lineColor,
    required this.gradientColor,
    this.gradientOpacity = 0.35,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (prices.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = lineColor
      ..isAntiAlias = true;

    // Normalize price values to canvas height
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final scaleY = maxPrice == minPrice
        ? 1
        : size.height / (maxPrice - minPrice);

    // Generate smooth cubic curve path
    final path = Path();
    for (int i = 0; i < prices.length; i++) {
      final x = (i / (prices.length - 1)) * size.width;
      final y = size.height - (prices[i] - minPrice) * scaleY;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = ((i - 1) / (prices.length - 1)) * size.width;
        final prevY = size.height - (prices[i - 1] - minPrice) * scaleY;

        final controlX1 = prevX + (x - prevX) / 3;
        final controlY1 = prevY;
        final controlX2 = x - (x - prevX) / 3;
        final controlY2 = y;

        path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }

    // --- Gradient fill under the curve ---
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradient = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, size.height),
      [
        gradientColor.withOpacity(gradientOpacity),
        gradientColor.withOpacity(0),
      ],
      [0.0, 1.0],
    );

    final fillPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // --- Draw the main curved line ---
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PriceChartPainter oldDelegate) =>
      oldDelegate.prices != prices ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.gradientColor != gradientColor;
}
