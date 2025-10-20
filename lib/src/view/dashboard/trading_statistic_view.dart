import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/color.dart';

import '../../model/trading_statistic.dart';

class TradingStatisticsList extends StatelessWidget {
  const TradingStatisticsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TradingStatistic> stats = [
      TradingStatistic(
        title: 'PRO traders',
        value: '17',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Trading days',
        value: '43',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Profit-share',
        value: '15%',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Total orders',
        value: '56',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Average losses',
        value: '0 USDT',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Total copy trades',
        value: '72',
        date: '15 May 2024 9:30AM',
      ),
      TradingStatistic(
        title: 'Asset under management (AUM)',
        value: '4766.72 USDT',
        date: '15 May 2024 9:30AM',
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
      separatorBuilder: (_, __) =>
          const Divider(height: 20, color: RoqquColors.border),
      itemBuilder: (context, index) {
        final stat = stats[index];
        return _StatTile(stat: stat);
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  final TradingStatistic stat;

  const _StatTile({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 32,
        children: [
          Expanded(
            child: Text(
              stat.title,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 13,
                color: RoqquColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: RoqquColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
