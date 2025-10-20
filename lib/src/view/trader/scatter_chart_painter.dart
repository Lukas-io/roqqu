import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:roqqu/src/core/theme/color.dart';

import '../../model/price_point.dart';

String formatNumber(double value) {
  if (value == 0) return '0';

  const suffixes = ['', 'k', 'M', 'B', 'T'];
  int i = 0;
  double v = value.abs();

  while (v >= 1000 && i < suffixes.length - 1) {
    v /= 1000;
    i++;
  }

  String formatted;
  if (v >= 100) {
    formatted = v.toStringAsFixed(0);
  } else if (v >= 10) {
    formatted = v.toStringAsFixed(1);
  } else {
    formatted = v.toStringAsFixed(2);
  }

  if (formatted.contains('.')) {
    formatted = formatted.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  if (value < 0) formatted = '-$formatted';

  return '$formatted${suffixes[i]}';
}

class ScatterChartPainter extends CustomPainter {
  final List<PricePoint> points;
  final double gridSpacing;
  final Color positiveColor;
  final Color negativeColor;
  final Color gridColor;
  final Color axisColor;

  const ScatterChartPainter({
    required this.points,
    this.gridSpacing = 50.0,
    this.positiveColor = Colors.green,
    this.negativeColor = Colors.red,
    this.gridColor = RoqquColors.border,
    this.axisColor = RoqquColors.buttonColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    const axisWidth = 24.0;
    const axisHeight = 12.0;

    final chartArea = Rect.fromLTWH(
      axisWidth,
      0,
      size.width - axisWidth,
      size.height - axisHeight,
    );

    final values = points.map((p) => p.price).toList();
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final valueRange = (maxValue == minValue ? 1 : maxValue - minValue)
        .toDouble();

    _drawGrid(canvas, chartArea);
    _drawAxes(canvas, chartArea, minValue, maxValue, valueRange);
    _drawScatterPoints(canvas, chartArea, points, minValue, valueRange);
  }

  void _drawGrid(Canvas canvas, Rect chartArea) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final numHorizontalLines = (chartArea.height / gridSpacing).ceil();
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
    double minValue,
    double maxValue,
    double valueRange,
  ) {
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Y-axis
    canvas.drawLine(
      Offset(chartArea.left, chartArea.top),
      Offset(chartArea.left, chartArea.bottom),
      axisPaint,
    );

    // X-axis
    canvas.drawLine(
      Offset(chartArea.left, chartArea.bottom),
      Offset(chartArea.right, chartArea.bottom),
      axisPaint,
    );

    // Y-axis labels
    final numLabelsY = 4;
    final yLabelPaint = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= numLabelsY; i++) {
      final ratio = i / numLabelsY;
      final value = maxValue - ratio * valueRange;
      final y = chartArea.top + ratio * (chartArea.height - 20);

      final text = formatNumber(value.abs());
      yLabelPaint.text = TextSpan(
        text: text,
        style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
      );
      yLabelPaint.layout();
      yLabelPaint.paint(
        canvas,
        Offset(
          chartArea.left - yLabelPaint.width - 6,
          y - yLabelPaint.height / 2,
        ),
      );
    }

    // X-axis labels
    if (points.isNotEmpty) {
      final numLabelsX = 4;
      final xLabelPaint = TextPainter(textDirection: TextDirection.ltr);

      for (int i = 0; i <= numLabelsX; i++) {
        final ratio = i / numLabelsX;
        final index = (ratio * (points.length - 1)).round();
        final timestamp = points[index].timestamp;
        final x = chartArea.left + ratio * (chartArea.width - 30) + 20;

        final timeStr = DateFormat('HH:mm').format(timestamp);
        xLabelPaint.text = TextSpan(
          text: timeStr,
          style: const TextStyle(color: Color(0xFF888888), fontSize: 10),
        );
        xLabelPaint.layout();
        xLabelPaint.paint(
          canvas,
          Offset(x - xLabelPaint.width / 2, chartArea.bottom + 4),
        );
      }
    }
  }

  void _drawScatterPoints(
    Canvas canvas,
    Rect chartArea,
    List<PricePoint> points,
    double minValue,
    double valueRange,
  ) {
    final scaleX = chartArea.width / (points.length - 1) * 0.85;
    final scaleY = chartArea.height / (valueRange == 0 ? 1 : valueRange) * 0.85;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final x = chartArea.left + i * scaleX;
      final y = chartArea.bottom - (point.price - minValue) * scaleY;

      final paint = Paint()
        ..color = point.price >= 0 ? positiveColor : negativeColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x + 15, y - 15), 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ScatterChartPainter oldDelegate) =>
      oldDelegate.points != points;
}
