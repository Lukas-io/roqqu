import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/model/trading_statistic.dart';
import 'package:roqqu/src/view/dashboard/trading_statistic_view.dart';

import '../../core/theme/color.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RoqquColors.card,
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  "Trading statistics",
                  style: GoogleFonts.encodeSans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: RoqquColors.text,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: RoqquColors.buttonColor,
                    minimumSize: Size.zero,
                    padding: EdgeInsetsGeometry.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '7 days',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: RoqquColors.text,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: RoqquColors.text,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TradingStatisticsList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  "Trading pairs",
                  style: GoogleFonts.encodeSans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: RoqquColors.text,
                  ),
                ),

                Wrap(
                  spacing: 8,
                  // runSpacing: 8,
                  children: tradingPairs
                      .map(
                        (pair) => TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: RoqquColors.buttonColor,
                            minimumSize: Size.zero,

                            padding: EdgeInsetsGeometry.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                          ),
                          child: Text(
                            pair,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: RoqquColors.textSecondary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
