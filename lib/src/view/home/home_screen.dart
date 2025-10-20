import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/controller/crypto_controller.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/home/copy_trading_banner.dart';
import 'package:roqqu/src/view/home/listed_coins_preview_widget.dart';
import 'package:roqqu/src/view/home/news_preview_widget.dart';
import 'package:roqqu/src/view/home/quick_balance_widget.dart';
import 'package:roqqu/src/view/home/refer_friend_banner.dart';
import 'package:roqqu/src/view/home/social_metrics_widget.dart';
import 'package:roqqu/src/view/home/movement_scroll_view.dart';
import 'package:roqqu/src/view/home/updates_scroll_view.dart';
import 'package:sprung/sprung.dart';

import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  final ValueNotifier<bool> _isLight = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    // Adjust threshold based on your header height
    if (_controller.offset > 100 && _isLight.value) {
      _isLight.value = false; // Switch to dark overlay
    } else if (_controller.offset <= 100 && !_isLight.value) {
      _isLight.value = true; // Switch to light overlay
    }
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CryptoController cryptoController = Get.find<CryptoController>();
    return ValueListenableBuilder<bool>(
      valueListenable: _isLight,
      builder: (context, isLight, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: !isLight
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: RoqquColors.background,
            body: Stack(
              alignment: AlignmentGeometry.topCenter,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFC0CFFE),
                        Color(0xFFF3DFF4),
                        Color(0xFFF9D8E5),
                      ],
                      stops: [0.0, 0.56, 0.96],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: _controller,
                  child: SafeArea(
                    child: Column(
                      children: [
                        HomeHeader(),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: Container(
                            color: RoqquColors.background,
                            child: Column(
                              spacing: 32,
                              children: [
                                QuickBalanceWidget(),
                                CopyTradingBanner(),
                                UpdatesScrollView(),
                                ListedCoinsPreviewWidget(),
                                MovementScrollView(title: "Top Gainers"),
                                MovementScrollView(title: "Top Losers"),
                                SocialMetricsWidget(),
                                MovementScrollView(title: "New Coins in Roqqu"),
                                NewsPreviewWidget(),
                                ReferFriendBanner(),
                                SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: SafeArea(
                    child: Obx(
                      () => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: 150.ms,
                        switchInCurve: Sprung(24),
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          // Scale from 0.7 -> 1.0
                          final scaleAnimation = Tween<double>(
                            begin: 0.7,
                            end: 1.0,
                          ).animate(animation);

                          // Slide from slightly above (10% above its final position)
                          final slideAnimation = Tween<Offset>(
                            begin: const Offset(0, -0.1),
                            // starts 10% above
                            end: Offset.zero,
                          ).animate(animation);

                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: slideAnimation,
                              child: ScaleTransition(
                                scale: scaleAnimation,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: cryptoController.isConnected.value
                            ? const SizedBox.shrink(key: ValueKey('connected'))
                            : Container(
                                key: const ValueKey('loading'),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: RoqquColors.background,
                                  border: Border.all(color: RoqquColors.border),
                                  boxShadow: [
                                    BoxShadow(
                                      color: RoqquColors.text.withOpacity(0.1),
                                      // soft shadow color
                                      spreadRadius: 12,
                                      // how much the shadow spreads
                                      blurRadius: 24,
                                      // blur effect
                                      offset: const Offset(
                                        0,
                                        4,
                                      ), // position of the shadow (x, y)
                                    ),
                                  ],
                                ),
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2.5,
                                  padding: EdgeInsetsGeometry.all(16),

                                  backgroundColor: RoqquColors.text,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
