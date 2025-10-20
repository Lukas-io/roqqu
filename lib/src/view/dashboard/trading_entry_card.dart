import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/color.dart';

import '../../model/trading_entry.dart';
import '../copy_trading/initial_avatar.dart';
import '../widgets/crypto_pair_avatar.dart';

class TradingEntryCard extends StatelessWidget {
  final TradingEntry entry;

  const TradingEntryCard({super.key, required this.entry});

  Color getRoiColor() {
    if (entry.roi > 0) return Colors.green;
    if (entry.roi < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: RoqquColors.buttonColor,
            padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CryptoPairAvatar(signalPair: entry.pair, size: 20),
                SizedBox(width: 8),
                Text(
                  entry.pair,
                  style: TextStyle(
                    fontSize: 14,
                    color: RoqquColors.textSecondary,
                  ),
                ),
                Text(
                  ' - ${entry.leverage}',
                  style: TextStyle(fontSize: 14, color: RoqquColors.textLink),
                ),
                Spacer(),
                Text(
                  '${entry.roi > 0 ? '+' : ''}${entry.roi.toStringAsFixed(2)}% ROI',
                  style: TextStyle(
                    color: getRoiColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              spacing: 16,
              children: [
                // Trader Info
                Row(
                  children: [
                    Text(
                      entry.traderType,
                      style: TextStyle(
                        fontSize: 14,
                        color: RoqquColors.textSecondary,
                      ),
                    ),
                    Spacer(),
                    InitialsAvatar(
                      initials: entry.traderName
                          .trim()
                          .split(RegExp(r'\s+'))
                          .map((name) => name.isNotEmpty ? name[0] : '')
                          .join()
                          .toUpperCase(),
                      size: 20,
                      isPro: true ?? entry.traderType.isNotEmpty,
                    ),
                    SizedBox(width: 8),
                    Text(
                      entry.traderName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                _buildLabelValue('Entry price', '${entry.entryPrice} USDT'),
                if (!entry.isOpen)
                  _buildLabelValue('Exit price', '${entry.exitPrice} USDT'),

                _buildLabelValue('Trader amount', '${entry.amount} USDT'),
                _buildLabelValue('Entry time', entry.entryTime),

                if (!entry.isOpen)
                  _buildLabelValue('Exit time', entry.exitTime),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: RoqquColors.textSecondary),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            color: RoqquColors.text,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
