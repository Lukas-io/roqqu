import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/utils.dart';

import '../../core/theme/color.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RoqquColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            "Copy trading assets",
            style: const TextStyle(
              color: RoqquColors.textSecondary,
              fontSize: 13,
            ),
          ),
          Text(
            format(903223),
            style: GoogleFonts.encodeSans(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: RoqquColors.text,
            ),
          ),
          Divider(color: RoqquColors.border, height: 34),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    "Net profit",
                    style: const TextStyle(
                      color: RoqquColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    format(4033),
                    style: GoogleFonts.encodeSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: RoqquColors.text,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 4,
                children: [
                  Text(
                    "Today’s PNL",
                    style: const TextStyle(
                      color: RoqquColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      changeArrow(90002, isSquiggle: true, size: 13),
                      Text(
                        format(903223),
                        style: GoogleFonts.encodeSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: getChangeColor(9032),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
