import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/model/trading_entry.dart';
import 'package:roqqu/src/view/dashboard/trading_entry_card.dart';

class CurrentTradesTab extends StatelessWidget {
  const CurrentTradesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RoqquColors.card,
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Column(
        children: tradingHistory
            .where((entry) => entry.isOpen)
            .map((entry) => TradingEntryCard(entry: entry))
            .toList(),
      ),
    );
  }
}
