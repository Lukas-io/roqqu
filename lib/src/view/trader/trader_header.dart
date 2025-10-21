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
        Wrap(
          spacing: 8,
          direction: Axis.horizontal,
          children: [
            TraderInfoChip("${trader.tradingDays} trading days"),
            TraderInfoChip("${trader.profitShare}% profit-share"),
            TraderInfoChip("${trader.totalOrders} total orders"),
          ],
        ),
      ],
    );
  }
}

class TraderInfoChip extends StatelessWidget {
  final String label;

  const TraderInfoChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFA7B1BC).withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        label,
        maxLines: 1,
        style: const TextStyle(
          color: RoqquColors.textSecondary,
          fontSize: 13,
          height: 1,
        ),
      ),
    );
  }
}
