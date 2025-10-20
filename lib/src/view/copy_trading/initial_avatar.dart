import 'package:flutter/material.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/theme/color.dart';

import '../../core/utils.dart';

class InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final double borderWidth;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool isPro;

  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.borderWidth = 1,
    this.backgroundColor,
    this.textStyle,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? getRandomColor();
    final defaultTextStyle = TextStyle(
      fontSize: size * 0.35,
      fontWeight: FontWeight.w700,
      color: RoqquColors.text,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.14),
            border: Border.all(color: color, width: borderWidth),
          ),
          alignment: Alignment.center,
          child: Text(
            initials.toUpperCase(),
            style: textStyle ?? defaultTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        if (isPro)
          Positioned(
            bottom: -size / 4,
            right: 0,
            child: Image.asset(
              RoqquAssets.proBadgeImage,
              width: size / 2.5,
              height: size / 2,
            ),
          ),
      ],
    );
  }
}
