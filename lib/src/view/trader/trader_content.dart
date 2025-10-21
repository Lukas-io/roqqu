import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/model/copy_trader.dart';
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
  final CopyTrader trader;

  const TraderContent(this.trader, {super.key});

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
            if (widget.trader.isPro)
              Stack(
                children: [
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: RoqquColors.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),

                        Text(
                          'Certified PROtrader',
                          style: GoogleFonts.encodeSans(
                            fontSize: 14,
                            color: RoqquColors.text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          spacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: RoqquColors.active.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              child: Row(
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(
                                    RoqquAssets.rateSvg,
                                    height: 16,
                                    width: 16,
                                  ),
                                  Text(
                                    'High win rate',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: RoqquColors.active,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: RoqquColors.warning.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              child: Row(
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(
                                    RoqquAssets.chartSvg,
                                    height: 16,
                                    width: 16,
                                  ),
                                  Text(
                                    'Great risk control',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: RoqquColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: SvgPicture.asset(
                      RoqquAssets.verifiedBannerSvg,
                      color: RoqquColors.textSecondary,
                    ),
                  ),
                ],
              ),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: RoqquColors.background,

                borderRadius: widget.trader.isPro
                    ? null
                    : const BorderRadius.only(
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
                isScrollable: true,
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
