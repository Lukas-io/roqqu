import 'package:flutter/material.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      separatorBuilder: (_, __) => const Divider(height: 20),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left section — Title and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.date,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),

          /// Right section — Value
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
