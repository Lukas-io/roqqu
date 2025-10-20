import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants.dart';
import '../../core/theme/color.dart';

class SocialMetricsWidget extends StatelessWidget {
  const SocialMetricsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What others are trading',
            style: GoogleFonts.encodeSans(
              fontSize: 14,
              color: RoqquColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          CryptoTabView(),
        ],
      ),
    );
  }
}

class CryptoTabView extends StatefulWidget {
  const CryptoTabView({super.key});

  @override
  State<CryptoTabView> createState() => _CryptoTabViewState();
}

class _CryptoTabViewState extends State<CryptoTabView> {
  final _currentTabIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final buying = [
      {'name': 'Bitcoin', 'icon': 'assets/images/bitcoin.png', 'change': 42.43},
      {
        'name': 'Ethereum',
        'icon': 'assets/images/ethereum.png',
        'change': 23.2,
      },
      {'name': 'Cardano', 'icon': 'assets/images/cardano.png', 'change': 17.5},
      {'name': 'DogeCoin', 'icon': 'assets/images/doge.png', 'change': 4.9},
    ];
    final selling = [
      {
        'name': 'Ethereum',
        'icon': 'assets/images/ethereum.png',
        'change': 32.2,
      },
      {'name': 'Bitcoin', 'icon': 'assets/images/bitcoin.png', 'change': 28.43},

      {'name': 'Cardano', 'icon': 'assets/images/cardano.png', 'change': 27.5},
      {'name': 'DogeCoin', 'icon': 'assets/images/doge.png', 'change': 12.9},
    ];

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: RoqquColors.card,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                labelColor: RoqquColors.text,
                onTap: (index) {
                  _currentTabIndex.value = index;
                },
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
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                overlayColor: WidgetStateProperty.all(Colors.transparent),

                tabs: const [
                  SizedBox(width: 88, height: 28, child: Tab(text: 'Buy')),
                  SizedBox(width: 88, height: 28, child: Tab(text: 'Sell')),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Obx(
            () => AnimatedSwitcher(
              duration: 300.ms,
              child: _currentTabIndex.value == 0
                  ? SocialMetricsView(cryptos: buying)
                  : SocialMetricsView(cryptos: selling),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMetricsView extends StatelessWidget {
  final List<Map<String, dynamic>> cryptos;

  const SocialMetricsView({super.key, required this.cryptos});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RoqquColors.border),
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: ListView.separated(
        itemCount: cryptos.length + 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(color: RoqquColors.border, height: 2);
        },
        itemBuilder: (context, index) {
          if (index >= cryptos.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Text(
                'This is a summary of the trades on Roqqu from the last 24hrs, this is an independent data and Roqqu will not be held liable for whatever you do with this information',
                style: TextStyle(
                  fontSize: 13,
                  color: RoqquColors.textSecondary,
                ),
              ),
            );
          }
          final coin = cryptos[index];
          final change = coin['change'] as double;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Row(
              children: [
                Image.asset(coin['icon'], width: 36, height: 36),
                const SizedBox(width: 16),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin['name'] + "- $change%",
                            style: GoogleFonts.encodeSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: RoqquColors.text,
                            ),
                          ),
                          SizedBox(height: 4),
                          Stack(
                            children: [
                              // Background bar
                              Container(
                                width: constraints.maxWidth,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(360),
                                ),
                              ),
                              Container(
                                width: constraints.maxWidth * change / 100,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(360),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
