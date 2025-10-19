import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/home/copy_trading_banner.dart';
import 'package:roqqu/src/view/home/listed_coins_preview_widget.dart';
import 'package:roqqu/src/view/home/new_coins_scroll_view.dart';
import 'package:roqqu/src/view/home/news_preview_widget.dart';
import 'package:roqqu/src/view/home/quick_balance_widget.dart';
import 'package:roqqu/src/view/home/refer_friend_banner.dart';
import 'package:roqqu/src/view/home/social_metrics_widget.dart';
import 'package:roqqu/src/view/home/top_movement_scroll_view.dart';
import 'package:roqqu/src/view/home/updates_scroll_view.dart';

import 'home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFC0CFFE), Color(0xFFF3DFF4), Color(0xFFF9D8E5)],
              stops: [0.0, 0.56, 0.96],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                HomeHeader(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Material(
                    color: RoqquColors.background,
                    child: Column(
                      spacing: 32,
                      children: [
                        QuickBalanceWidget(),
                        CopyTradingBanner(),
                        UpdatesScrollView(),
                        ListedCoinsPreviewWidget(),
                        TopMovementScrollView(),
                        SocialMetricsWidget(),
                        NewCoinsScrollView(),
                        NewsPreviewWidget(),
                        ReferFriendBanner(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
