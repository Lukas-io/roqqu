import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/color.dart';

class InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final bool isPro;

  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.borderColor = const Color(0xFF5283FF),
    this.borderWidth = 1,
    this.backgroundColor = const Color(0xFF283349),
    this.textStyle,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: size * 0.42,
      fontWeight: FontWeight.w700,
      color: RoqquColors.text,
    );

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: textStyle ?? defaultTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
