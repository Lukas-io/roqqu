import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/copy_trader.dart';

class CopyTraderSummaryCard extends StatelessWidget {
  final CopyTrader trader;

  const CopyTraderSummaryCard({super.key, required this.trader});

  @override
  Widget build(BuildContext context) {
    final initials = trader.name
        .split(' ')
        .map((name) => name.substring(0, 1))
        .take(2)
        .join();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Text(
              initials,
              style: GoogleFonts.encodeSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trader.name,
                  style: GoogleFonts.encodeSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetric("Total volume", "${trader.totalVolume} USDT"),
                    _buildMetric(
                      "Trading profit",
                      "${trader.tradingProfit} USDT",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.encodeSans(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.encodeSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
