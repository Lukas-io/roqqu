import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/dashboard/stats_tab.dart';
import 'package:roqqu/src/view/dashboard/traders_tab.dart';

import 'chart_tab.dart';
import 'current_trades_tab.dart';

enum CopyTabs {
  chart('Chart', ChartTab()),
  currentTrades('Current trades', CurrentTradesTab()),
  stats('Stats', StatsTab()),
  myTraders('My traders', TradersTab("PRO traders"));

  final String title;
  final Widget widget;

  const CopyTabs(this.title, this.widget);
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
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
        length: CopyTabs.values.length,
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
                isScrollable: true,

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

                tabs: CopyTabs.values
                    .map(
                      (tab) => Tab(
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 17.1,
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
                children: CopyTabs.values.map((tab) => tab.widget).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
