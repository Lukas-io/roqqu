import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/view/copy_trading/initial_avatar.dart';

import '../../model/copy_trader.dart';

class TraderSummaryCard extends StatelessWidget {
  final CopyTrader trader;

  const TraderSummaryCard({super.key, required this.trader});

  String get initials {
    final parts = trader.name.split(" ");
    if (parts.length == 1) return parts.first.substring(0, 2).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              InitialsAvatar(initials: initials, size: 32),
              Text(
                trader.name,
                style: TextStyle(
                  color: RoqquColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              if (Random().nextBool())
                Image.asset(RoqquAssets.proBadgeImage, width: 30, height: 30),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildMetric("Total volume", "${trader.aum} USDT"),
              Spacer(),
              _buildMetric(
                "Trading profit",
                alignment: CrossAxisAlignment.end,
                "${format(trader.totalProfitLoss, currency: "")} USDT",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(
    String label,
    String value, {
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: RoqquColors.textSecondary),
        ),

        Text(
          value,
          style: GoogleFonts.encodeSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: RoqquColors.text,
          ),
        ),
      ],
    );
  }
}
