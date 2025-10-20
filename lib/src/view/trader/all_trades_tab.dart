import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/color.dart';
import '../../model/trading_entry.dart';
import '../dashboard/trading_entry_card.dart';

class AllTradesTab extends StatelessWidget {
  const AllTradesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTabIndex = 0.obs;

    return DefaultTabController(
      length: 2,
      child: Container(
        color: RoqquColors.card,
        padding: EdgeInsetsGeometry.symmetric(vertical: 12),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: RoqquColors.buttonColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    labelColor: RoqquColors.text,
                    onTap: (index) {
                      currentTabIndex.value = index;
                    },
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    unselectedLabelColor: RoqquColors.text,
                    indicator: BoxDecoration(
                      color: RoqquColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    dividerHeight: 0,
                    indicatorAnimation: TabIndicatorAnimation.elastic,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: const [
                      SizedBox(
                        width: 120,
                        height: 28,
                        child: Tab(text: 'Current trades'),
                      ),
                      SizedBox(
                        width: 88,
                        height: 28,
                        child: Tab(text: 'History'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),

              ...tradingHistory
                  .where((entry) {
                    return currentTabIndex.value != 0 ? true : entry.isOpen;
                  })
                  .map((entry) => TradingEntryCard(entry: entry)),
            ],
          ),
        ),
      ),
    );
  }
}
