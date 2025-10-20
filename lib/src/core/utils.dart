import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu/src/core/theme/color.dart';

import 'assets.dart';

final _formatter = NumberFormat('#,##0.00', 'en_US');

/// Formats a price with commas and the Euro sign.
///
/// Example:
/// ```dart
/// PriceFormatter.format(12345.678); // €12,345.68
/// PriceFormatter.format(500);       // €500.00
/// ```
String format(num value, {bool showCents = true, String currency = "€"}) {
  if (value.abs() >= 100) {
    showCents = false;
  }
  bool isNegative = value < 0;
  value = value.abs();
  if (isNegative) currency = "-$currency";

  if (!showCents) {
    final noDecimalFormatter = NumberFormat('#,##0', 'en_US');
    return '$currency${noDecimalFormatter.format(value)}';
  }
  return '$currency${_formatter.format(value)}';
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
