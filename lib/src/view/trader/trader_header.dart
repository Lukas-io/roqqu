import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/model/copy_trader.dart';

import '../../core/assets.dart';
import '../../core/theme/color.dart';
import '../copy_trading/initial_avatar.dart';

class TraderHeader extends StatelessWidget {
  final CopyTrader trader;

  const TraderHeader(this.trader, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12,
          children: [
            InitialsAvatar(
              initials: trader.name
                  .trim()
                  .split(RegExp(r'\s+'))
                  .map((name) => name.isNotEmpty ? name[0] : '')
                  .join()
                  .toUpperCase(),
              isPro: trader.isPro,
              size: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  trader.name,
                  style: GoogleFonts.encodeSans(
                    fontSize: 18,
                    color: RoqquColors.text,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      RoqquAssets.peopleSvg,
                      color: RoqquColors.link,
                    ),
                    Text(
                      '${trader.copiers} people',
                      style: TextStyle(
                        fontSize: 13,
                        color: RoqquColors.textLink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFA7B1BC).withOpacity(0.08),
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                alignment: AlignmentGeometry.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trader.tradingDays} trading days",
                      style: const TextStyle(
                        color: RoqquColors.textSecondary,
                        fontSize: 13,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFA7B1BC).withOpacity(0.08),
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                alignment: AlignmentGeometry.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trader.profitShare}% profit-share",
                      style: const TextStyle(
                        color: RoqquColors.textSecondary,
                        fontSize: 13,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFA7B1BC).withOpacity(0.08),
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                alignment: AlignmentGeometry.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trader.totalOrders} total orders",
                      style: const TextStyle(
                        color: RoqquColors.textSecondary,
                        fontSize: 13,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
