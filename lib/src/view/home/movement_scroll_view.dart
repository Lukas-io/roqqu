import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/view/home/listed_coins_preview_widget.dart';

import '../../core/theme/color.dart';
import '../widgets/crypto_pair_avatar.dart';
import '../widgets/price_painter.dart';

final prices = [120.0, 122.5, 121.0, 125.0, 128.0, 124.0];

class MovementScrollView extends StatelessWidget {
  final String title;

  const MovementScrollView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            spacing: 16,
            children: CryptoAsset.values
                .map(
                  (crypto) => Container(
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
                            CryptoPairAvatar(signalPair: crypto.pair, size: 24),
                            Text(
                              crypto.pair,
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
                          format(900),
                          style: GoogleFonts.encodeSans(
                            fontSize: 18,
                            color: RoqquColors.text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          spacing: 12,
                          children: [
                            Text(
                              "90%",
                              style: TextStyle(
                                color: getChangeColor(90),
                                fontSize: 14,
                              ),
                            ),

                            changeArrow(90),
                            Spacer(),
                            CustomPaint(
                              painter: PriceChartPainter(
                                prices: prices,
                                lineColor: getChangeColor(90),
                                gradientColor: getChangeColor(90),
                              ),
                              size: const Size(36, 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
