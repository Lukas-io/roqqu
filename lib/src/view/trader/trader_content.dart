import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/view/trader/all_trades_tab.dart';

import '../../core/theme/color.dart';
import '../dashboard/chart_tab.dart';
import '../dashboard/stats_tab.dart';
import '../dashboard/traders_tab.dart';

enum TraderTabs {
  chart('Chart', ChartTab(isTrader: true)),
  stats('Stats', StatsTab()),
  currentTrades('All trades', AllTradesTab()),
  myTraders('Copiers', TradersTab("copiers"));

  final String title;
  final Widget widget;

  const TraderTabs(this.title, this.widget);
}

class TraderContent extends StatefulWidget {
  const TraderContent({super.key});

  @override
  State<TraderContent> createState() => _TraderContentState();
}

class _TraderContentState extends State<TraderContent> {
  final _currentTabIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RoqquColors.border),
      ),
      clipBehavior: Clip.hardEdge,

      child: DefaultTabController(
        length: TraderTabs.values.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: RoqquColors.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: TabBar(
                labelColor: RoqquColors.text,
                onTap: (index) {
                  _currentTabIndex.value = index;
                },
                unselectedLabelColor: RoqquColors.text,

                indicatorColor: RoqquColors.link,
                dividerHeight: 0,
                indicatorWeight: 1,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                tabAlignment: TabAlignment.center,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),

                tabs: TraderTabs.values
                    .map(
                      (tab) => Tab(
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 23.5,
                          ),
                          child: Text(tab.title),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            Obx(
              () => IndexedStack(
                index: _currentTabIndex.value,
                children: TraderTabs.values.map((tab) => tab.widget).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
