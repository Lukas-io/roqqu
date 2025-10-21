import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/view/home/listed_coins_preview_widget.dart';

import '../../controller/crypto_controller.dart';
import '../../core/theme/color.dart';
import '../widgets/crypto_pair_avatar.dart';
import '../widgets/minimal_price_chart_painter.dart';

class MovementScrollView extends StatelessWidget {
  final String title;
  final bool? gainer;

  const MovementScrollView({super.key, required this.title, this.gainer});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.find<CryptoController>();

    return Column(
      spacing: 12,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: RoqquConstants.horizontalPadding,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.encodeSans(
                  fontSize: 14,
                  color: RoqquColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  color: RoqquColors.textLink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: RoqquConstants.horizontalPadding,
          ),
          scrollDirection: Axis.horizontal,
          child: Obx(() {
            var data = controller.cryptoDataMap.entries;

            if (gainer != null) {
              if (gainer!) {
                data = data.where(
                  (entry) => !entry.value.priceChangePercent24h.isNegative,
                );
              } else {
                data = data.where(
                  (entry) => entry.value.priceChangePercent24h.isNegative,
                );
              }
            }
            if (data.isEmpty) {
              return SizedBox(
                height: 75,
                child: Center(
                  child: Text(
                    "No ${title.toLowerCase()} at the moment",
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: RoqquColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }

            return Row(
              spacing: 16,
              children: data.map((entry) {
                return Container(
                  padding: EdgeInsets.all(16),
                  width: 160,

                  decoration: BoxDecoration(
                    color: RoqquColors.card,
                    borderRadius: BorderRadiusGeometry.circular(16),
                    border: Border.all(color: RoqquColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          CryptoPairAvatar(signalPair: entry.key, size: 24),
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 15,
                              color: RoqquColors.textSecondary,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        format(entry.value.currentPrice),
                        style: GoogleFonts.encodeSans(
                          fontSize: 18,
                          color: RoqquColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            "${entry.value.priceChangePercent24h.toPrecision(2)}%",
                            style: TextStyle(
                              color: getChangeColor(
                                entry.value.priceChangePercent24h,
                              ),
                              fontSize: 14,
                            ),
                          ),

                          changeArrow(entry.value.priceChangePercent24h),
                          Spacer(),
                          CustomPaint(
                            painter: MinimalPriceChartPainter(
                              prices: entry.value.historicalData
                                  .map((price) => price.price)
                                  .toList(),
                              lineColor: getChangeColor(
                                entry.value.priceChangePercent24h,
                              ),
                              gradientColor: getChangeColor(
                                entry.value.priceChangePercent24h,
                              ),
                            ),
                            size: const Size(36, 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}
