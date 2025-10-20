import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:roqqu/src/core/theme/color.dart';

import '../../model/price_point.dart';

String formatNumber(double value) {
  if (value == 0) return '0';

  const suffixes = ['', 'k', 'M', 'B', 'T'];
  int i = 0;
  double v = value.abs();

  // Determine suffix
  while (v >= 1000 && i < suffixes.length - 1) {
    v /= 1000;
    i++;
  }

  // Limit to 3 significant figures
  String formatted;
  if (v >= 100) {
    formatted = v.toStringAsFixed(0); // e.g., 123k
  } else if (v >= 10) {
    formatted = v.toStringAsFixed(1); // e.g., 12.3k
  } else {
    formatted = v.toStringAsFixed(2); // e.g., 1.23k
  }

  // Remove trailing zeros after decimal, but keep integer part intact
  if (formatted.contains('.')) {
    formatted = formatted.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  // Keep negative sign if needed
  if (value < 0) formatted = '-$formatted';

  return '$formatted${suffixes[i]}';
}

class PriceChartPainter extends CustomPainter {
  final List<PricePoint> pricePoints;
  final Color lineColor;
  final double gradientOpacity;
  final Color gridColor;
  final Color axisColor;
  final double gridSpacing;

  const PriceChartPainter({
    required this.pricePoints,
    required this.lineColor,
    this.gradientOpacity = 0.35,
    this.gridColor = RoqquColors.border,
    this.axisColor = RoqquColors.buttonColor,
    this.gridSpacing = 50.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (pricePoints.isEmpty) return;

    const axisWidth = 24.0;
    const axisHeight = 12.0;

    final chartArea = Rect.fromLTWH(
      axisWidth,
      0,
      size.width - axisWidth,
      size.height - axisHeight,
    );

    // Extract prices and find min/max
    final prices = pricePoints.map((p) => p.price).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final priceRange = (maxPrice == minPrice ? 1 : maxPrice - minPrice)
        .toDouble();

    // Draw grid and axes
    _drawGrid(canvas, chartArea, minPrice, maxPrice, priceRange);
    _drawAxes(canvas, chartArea, minPrice, maxPrice, priceRange);

    // Draw chart
    _drawChart(canvas, chartArea, prices, minPrice, priceRange);
  }

  void _drawGrid(
    Canvas canvas,
    Rect chartArea,
    double minPrice,
    double maxPrice,
    double priceRange,
  ) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final numHorizontalLines = ((chartArea.height) / gridSpacing).ceil();
    for (int i = 0; i <= numHorizontalLines; i++) {
      final y = chartArea.top + (i * gridSpacing);
      if (y <= chartArea.bottom) {
        canvas.drawLine(
          Offset(chartArea.left, y),
          Offset(chartArea.right, y),
          gridPaint,
        );
      }
    }
  }

  void _drawAxes(
    Canvas canvas,
    Rect chartArea,
    double minPrice,
    double maxPrice,
    double priceRange,
  ) {
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Y-axis (left)
    canvas.drawLine(
      Offset(chartArea.left, chartArea.top),
      Offset(chartArea.left, chartArea.bottom),
      axisPaint,
    );

    // X-axis (bottom)
    canvas.drawLine(
      Offset(chartArea.left, chartArea.bottom),
      Offset(chartArea.right, chartArea.bottom),
      axisPaint,
    );

    // Y-axis labels (prices)
    final numLabelsY = 4;
    final yLabelPaint = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= numLabelsY; i++) {
      final ratio = i / numLabelsY;
      final price = maxPrice - (ratio * priceRange);
      final y = chartArea.top + (ratio * (chartArea.height - 20)) + 5;

      final text = formatNumber(price);
      yLabelPaint.text = TextSpan(
        text: text,
        style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
      );
      yLabelPaint.layout();
      yLabelPaint.paint(
        canvas,
        Offset(
          chartArea.left - yLabelPaint.width - 8,
          y - yLabelPaint.height / 2,
        ),
      );
    }

    // X-axis labels (time)
    if (pricePoints.isNotEmpty) {
      final numLabelsX = 4;
      final xLabelPaint = TextPainter(textDirection: TextDirection.ltr);

      for (int i = 0; i <= numLabelsX; i++) {
        final ratio = i / numLabelsX;
        final index = (ratio * (pricePoints.length - 1)).round();
        final timestamp = pricePoints[index].timestamp;
        final x = chartArea.left + (ratio * (chartArea.width - 25)) + 10;

        final timeStr = DateFormat('HH:mm').format(timestamp);
        xLabelPaint.text = TextSpan(
          text: timeStr,
          style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
        );
        xLabelPaint.layout();
        xLabelPaint.paint(
          canvas,
          Offset(x - xLabelPaint.width / 2, chartArea.bottom + 8),
        );
      }
    }
  }

  void _drawChart(
    Canvas canvas,
    Rect chartArea,
    List<double> prices,
    double minPrice,
    double priceRange,
  ) {
    final scaleY = chartArea.height / (priceRange == 0 ? 1 : priceRange) * 0.7;
    final scaleX =
        chartArea.width / (prices.length > 1 ? prices.length - 1 : 1);

    // Build smooth path
    final path = Path();
    for (int i = 0; i < prices.length; i++) {
      final x = chartArea.left + (i * scaleX);
      final y = chartArea.bottom - (prices[i] - minPrice) * scaleY;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = chartArea.left + ((i - 1) * scaleX);
        final prevY = (chartArea.bottom) - (prices[i - 1] - minPrice) * scaleY;

        final controlX1 = prevX + scaleX / 3;
        final controlY1 = prevY;
        final controlX2 = x - scaleX / 3;
        final controlY2 = y;

        path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }

    // Gradient fill
    final fillPath = Path.from(path)
      ..lineTo(chartArea.right, chartArea.bottom + 30)
      ..lineTo(chartArea.left, chartArea.bottom + 30)
      ..close();

    final gradient = ui.Gradient.linear(
      Offset(0, chartArea.top),
      Offset(0, chartArea.bottom),
      [lineColor.withOpacity(gradientOpacity), lineColor.withOpacity(0)],
      [0.0, 1.0],
    );

    final fillPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath.shift(Offset(0, -30)), fillPaint);

    // Line
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = lineColor
      ..isAntiAlias = true;
    // Line
    final pointPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.5
      ..color = lineColor
      ..isAntiAlias = true;

    canvas.drawPath(path.shift(Offset(0, -30)), linePaint);
    canvas.drawCircle(
      Offset(
        chartArea.right,
        chartArea.bottom - (prices.last - minPrice) * scaleY - 30,
      ),
      4,
      pointPaint,
    );

    drawDashedLine(
      canvas,
      Offset(
        chartArea.left,
        chartArea.bottom - (prices.last - minPrice) * scaleY - 30,
      ),
      Offset(
        chartArea.right,
        chartArea.bottom - (prices.last - minPrice) * scaleY - 30,
      ),

      pointPaint
        ..strokeWidth = 0.3
        ..color = RoqquColors.text,
    );
  }

  void drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;

    final distance = (end - start).distance;
    final direction = (end - start) / distance; // unit vector

    double progress = 0;
    while (progress < distance) {
      final segmentEnd = (progress + dashWidth).clamp(0, distance);
      canvas.drawLine(
        start + direction * progress,
        start + direction * segmentEnd.toDouble(),
        paint,
      );
      progress += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant PriceChartPainter oldDelegate) =>
      oldDelegate.pricePoints != pricePoints ||
      oldDelegate.lineColor != lineColor
  //     ||
  // oldDelegate.heldPoint != heldPoint ||
  // oldDelegate.heldPricePoint != heldPricePoint
  ;
}

//
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' hide TextDirection;
//
// import '../../model/price_point.dart';
//
// class PriceChartPainter extends CustomPainter {
//   final List<PricePoint> pricePoints;
//   final Color lineColor;
//   final Color gradientColor;
//   final double gradientOpacity;
//   final Color gridColor;
//   final Color axisColor;
//   final double gridSpacing;
//   final Offset? heldPoint;
//   final PricePoint? heldPricePoint;
//
//   const PriceChartPainter({
//     required this.pricePoints,
//     required this.lineColor,
//     required this.gradientColor,
//     this.gradientOpacity = 0.35,
//     this.gridColor = const Color(0x20FFFFFF),
//     this.axisColor = const Color(0xFF888888),
//     this.gridSpacing = 50.0,
//     this.heldPoint,
//     this.heldPricePoint,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (pricePoints.isEmpty) return;
//
//     const axisWidth = 60.0;
//     const axisHeight = 40.0;
//
//     final chartArea = Rect.fromLTWH(
//       axisWidth,
//       0,
//       size.width - axisWidth,
//       size.height - axisHeight,
//     );
//
//     final prices = pricePoints.map((p) => p.price).toList();
//     final minPrice = prices.reduce((a, b) => a < b ? a : b);
//     final maxPrice = prices.reduce((a, b) => a > b ? a : b);
//     final priceRange = (maxPrice == minPrice ? 1 : maxPrice - minPrice)
//         .toDouble();
//
//     _drawGrid(canvas, chartArea, minPrice, maxPrice, priceRange);
//     _drawAxes(canvas, chartArea, minPrice, maxPrice, priceRange);
//     _drawChart(canvas, chartArea, prices, minPrice, priceRange);
//
//     if (heldPoint != null && heldPricePoint != null) {
//       _drawHeldPoint(
//         canvas,
//         chartArea,
//         heldPoint!,
//         heldPricePoint!,
//         minPrice,
//         priceRange,
//       );
//     }
//   }
//
//   void _drawGrid(
//       Canvas canvas,
//       Rect chartArea,
//       double minPrice,
//       double maxPrice,
//       double priceRange,
//       ) {
//     final gridPaint = Paint()
//       ..color = gridColor
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke;
//
//     final numVerticalLines = ((chartArea.width) / gridSpacing).ceil();
//     for (int i = 0; i <= numVerticalLines; i++) {
//       final x = chartArea.left + (i * gridSpacing);
//       if (x <= chartArea.right) {
//         _drawDottedLine(
//           canvas,
//           Offset(x, chartArea.top),
//           Offset(x, chartArea.bottom),
//           gridPaint,
//         );
//       }
//     }
//
//     final numHorizontalLines = ((chartArea.height) / gridSpacing).ceil();
//     for (int i = 0; i <= numHorizontalLines; i++) {
//       final y = chartArea.top + (i * gridSpacing);
//       if (y <= chartArea.bottom) {
//         _drawDottedLine(
//           canvas,
//           Offset(chartArea.left, y),
//           Offset(chartArea.right, y),
//           gridPaint,
//         );
//       }
//     }
//   }
//
//   void _drawAxes(
//       Canvas canvas,
//       Rect chartArea,
//       double minPrice,
//       double maxPrice,
//       double priceRange,
//       ) {
//     final axisPaint = Paint()
//       ..color = axisColor
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;
//
//     canvas.drawLine(
//       Offset(chartArea.left, chartArea.top),
//       Offset(chartArea.left, chartArea.bottom),
//       axisPaint,
//     );
//
//     canvas.drawLine(
//       Offset(chartArea.left, chartArea.bottom),
//       Offset(chartArea.right, chartArea.bottom),
//       axisPaint,
//     );
//
//     final numLabelsY = 5;
//     final yLabelPaint = TextPainter(textDirection: TextDirection.ltr);
//
//     for (int i = 0; i <= numLabelsY; i++) {
//       final ratio = i / numLabelsY;
//       final price = maxPrice - (ratio * priceRange);
//       final y = chartArea.top + (ratio * chartArea.height);
//
//       final text = price.toStringAsFixed(2);
//       yLabelPaint.text = TextSpan(
//         text: text,
//         style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
//       );
//       yLabelPaint.layout();
//       yLabelPaint.paint(
//         canvas,
//         Offset(
//           chartArea.left - yLabelPaint.width - 8,
//           y - yLabelPaint.height / 2,
//         ),
//       );
//     }
//
//     if (pricePoints.isNotEmpty) {
//       final numLabelsX = 4;
//       final xLabelPaint = TextPainter(textDirection: TextDirection.ltr);
//
//       for (int i = 0; i <= numLabelsX; i++) {
//         final ratio = i / numLabelsX;
//         final index = (ratio * (pricePoints.length - 1)).round();
//         final timestamp = pricePoints[index].timestamp;
//         final x = chartArea.left + (ratio * chartArea.width);
//
//         final timeStr = DateFormat('HH:mm').format(timestamp);
//         xLabelPaint.text = TextSpan(
//           text: timeStr,
//           style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
//         );
//         xLabelPaint.layout();
//         xLabelPaint.paint(
//           canvas,
//           Offset(x - xLabelPaint.width / 2, chartArea.bottom + 8),
//         );
//       }
//     }
//   }
//
//   void _drawChart(
//       Canvas canvas,
//       Rect chartArea,
//       List<double> prices,
//       double minPrice,
//       double priceRange,
//       ) {
//     final scaleY = chartArea.height / (priceRange == 0 ? 1 : priceRange);
//     final scaleX =
//         chartArea.width / (prices.length > 1 ? prices.length - 1 : 1);
//
//     final path = Path();
//     for (int i = 0; i < prices.length; i++) {
//       final x = chartArea.left + (i * scaleX);
//       final y = chartArea.bottom - (prices[i] - minPrice) * scaleY;
//
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         final prevX = chartArea.left + ((i - 1) * scaleX);
//         final prevY = chartArea.bottom - (prices[i - 1] - minPrice) * scaleY;
//
//         final controlX1 = prevX + scaleX / 3;
//         final controlY1 = prevY;
//         final controlX2 = x - scaleX / 3;
//         final controlY2 = y;
//
//         path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
//       }
//     }
//
//     final fillPath = Path.from(path)
//       ..lineTo(chartArea.right, chartArea.bottom)
//       ..lineTo(chartArea.left, chartArea.bottom)
//       ..close();
//
//     final gradient = ui.Gradient.linear(
//       Offset(0, chartArea.top),
//       Offset(0, chartArea.bottom),
//       [
//         gradientColor.withOpacity(gradientOpacity),
//         gradientColor.withOpacity(0),
//       ],
//       [0.0, 1.0],
//     );
//
//     final fillPaint = Paint()
//       ..shader = gradient
//       ..style = PaintingStyle.fill;
//
//     canvas.drawPath(fillPath, fillPaint);
//
//     final linePaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.5
//       ..color = lineColor
//       ..isAntiAlias = true;
//
//     canvas.drawPath(path, linePaint);
//   }
//
//   void _drawHeldPoint(
//       Canvas canvas,
//       Rect chartArea,
//       Offset heldPos,
//       PricePoint point,
//       double minPrice,
//       double priceRange,
//       ) {
//     final crosshairPaint = Paint()
//       ..color = Colors.white.withOpacity(0.6)
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke;
//
//     canvas.drawLine(
//       Offset(chartArea.left, heldPos.dy),
//       Offset(chartArea.right, heldPos.dy),
//       crosshairPaint,
//     );
//     canvas.drawLine(
//       Offset(heldPos.dx, chartArea.top),
//       Offset(heldPos.dx, chartArea.bottom),
//       crosshairPaint,
//     );
//
//     final pointPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     canvas.drawCircle(heldPos, 5, pointPaint);
//
//     final tooltipText =
//         '${point.price.toStringAsFixed(2)}\n${DateFormat('HH:mm:ss').format(point.timestamp)}';
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: tooltipText,
//         style: const TextStyle(color: Colors.white, fontSize: 12),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//
//     final tooltipPaint = Paint()
//       ..color = Colors.black.withOpacity(0.7)
//       ..style = PaintingStyle.fill;
//
//     final tooltipRect = Rect.fromLTWH(
//       heldPos.dx + 10,
//       heldPos.dy - textPainter.height - 10,
//       textPainter.width + 8,
//       textPainter.height + 4,
//     );
//
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(tooltipRect, Radius.circular(4)),
//       tooltipPaint,
//     );
//
//     textPainter.paint(canvas, tooltipRect.topLeft + const Offset(4, 2));
//   }
//
//   void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//     const dashWidth = 4.0;
//     const dashSpace = 4.0;
//     final distance = (end - start).distance;
//     final direction = (end - start) / distance;
//
//     double progress = 0;
//     while (progress < distance) {
//       final segmentEnd = (progress + dashWidth).clamp(0, distance);
//       canvas.drawLine(
//         start + direction * progress,
//         start + direction * segmentEnd.toDouble(),
//         paint,
//       );
//       progress += dashWidth + dashSpace;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant PriceChartPainter oldDelegate) =>
//       oldDelegate.pricePoints != pricePoints ||
//           oldDelegate.lineColor != lineColor ||
//           oldDelegate.gradientColor != gradientColor ||
//           oldDelegate.heldPoint != heldPoint ||
//           oldDelegate.heldPricePoint != heldPricePoint;
// }
