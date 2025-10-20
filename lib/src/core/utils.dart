import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu/src/core/theme/color.dart';

import 'assets.dart';

Color getColorFromString(String value) {
  // Define your three colors
  const colors = [
    Color(0xFFF79009), // orange
    Color(0xFF5283FF), // blue
    Color(0xFF85D1F0), // light blue
  ];

  // Use the string to generate a stable hash
  final hash = value.codeUnits.fold(0, (prev, elem) => prev + elem);

  // Map hash to a color index
  final index = hash % colors.length;
  return colors[index];
}

/// Formats a price with commas and the Euro sign.
///
/// Example:
/// ```dart
/// PriceFormatter.format(12345.678); // €12,345.68
/// PriceFormatter.format(500);       // €500.00
/// ```
String format(num value, {bool showCents = true, String currency = "\$"}) {
  if (value.abs() >= 100) {
    showCents = false;
  }
  NumberFormat formatter;
  formatter = NumberFormat('#,##0.00', 'en_US');
  if (value.abs() < 1) {
    formatter = NumberFormat('#,##0.000', 'en_US');
  }

  bool isNegative = value < 0;
  value = value.abs();
  if (isNegative) currency = "-$currency";

  if (!showCents) {
    final noDecimalFormatter = NumberFormat('#,##0', 'en_US');
    return '$currency${noDecimalFormatter.format(value)}';
  }
  return '$currency${formatter.format(value)}';
}

Color getChangeColor(double value) {
  if (value > 0) {
    return RoqquColors.active;
  } else if (value < 0) {
    return RoqquColors.error;
  } else {
    return RoqquColors.textSecondary;
  }
}

Widget changeArrow(double value, {bool isSquiggle = false, double size = 8}) {
  return Transform.rotate(
    angle: value < 0 ? 270 * math.pi / 180 : 0,
    child: SvgPicture.asset(
      isSquiggle ? RoqquAssets.arrowSvg : RoqquAssets.changeArrowSvg,
      color: getChangeColor(value),
      height: size,
      width: size,
    ),
  );
}
