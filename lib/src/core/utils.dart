import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu/src/core/theme/color.dart';

import 'assets.dart';

String formatEuro(double value) {
  if (value < 100) {
    return '€${value.toStringAsFixed(2)}';
  } else {
    return '€${value.toStringAsFixed(0)}';
  }
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

Widget changeArrow(double value) {
  return Transform.rotate(
    angle: value < 0 ? 270 * math.pi / 180 : 0,
    child: SvgPicture.asset(
      RoqquAssets.changeArrowSvg,
      color: getChangeColor(value),
      height: 8,
      width: 8,
    ),
  );
}
