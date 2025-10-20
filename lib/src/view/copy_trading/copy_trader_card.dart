import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/copy_trading/initial_avatar.dart';

import '../../core/utils.dart';
import '../../model/copy_trader.dart';
import '../trader/trader_screen.dart';
import '../widgets/minimal_price_chart_painter.dart';

class CopyTraderCard extends StatefulWidget {
  final CopyTrader trader;

  const CopyTraderCard({super.key, required this.trader});

  @override
  State<CopyTraderCard> createState() => _CopyTraderCardState();
}

class _CopyTraderCardState extends State<CopyTraderCard>
    with SingleTickerProviderStateMixin {
  final RxDouble _scale = 1.0.obs;

  void _onTapDown(TapDownDetails details) {
    _scale.value = 0.95;
  }

  void _onTapUp(TapUpDetails details) {
    _scale.value = 1.0;
  }

  void _onTapCancel() {
    _scale.value = 1.0;
  }

  void onPressed() => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TraderScreen(trader: widget.trader),
    ),
  );

  final isCopied = false.obs;

  @override
  Widget build(BuildContext context) {
    final isProfit = widget.trader.totalProfitLoss >= 0;

    return Obx(() {
      return GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: onPressed,
        child: AnimatedScale(
          scale: _scale.value,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              color: RoqquColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: RoqquColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          InitialsAvatar(
                            initials: widget.trader.name
                                .trim()
                                .split(RegExp(r'\s+'))
                                .map((name) => name.isNotEmpty ? name[0] : '')
                                .join()
                                .toUpperCase(),
                            isPro: widget.trader.isPro,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.trader.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    RoqquAssets.peopleSvg,
                                    color: RoqquColors.link,
                                  ),
                                  Text(
                                    '${widget.trader.copiers} people',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: RoqquColors.textLink,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => isCopied.value = true,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 6,
                                horizontal: 22,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: RoqquColors.border),
                                color: isCopied.value
                                    ? RoqquColors.buttonColor
                                    : RoqquColors.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AnimatedSize(
                                duration: 300.ms,
                                clipBehavior: Clip.none,
                                curve: Curves.easeOut,
                                child: Text(
                                  isCopied.value ? 'Copied' : 'Copy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: RoqquColors.textSecondary,
                                    fontWeight: isCopied.value
                                        ? FontWeight.w600
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: RoqquColors.border, height: 34),
                      Row(
                        spacing: 32,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ROI",
                                  style: const TextStyle(
                                    color: RoqquColors.textSecondary,
                                    fontSize: 13,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  '${isProfit ? "+" : ""}${widget.trader.roi.toStringAsFixed(2)}%',
                                  style: GoogleFonts.encodeSans(
                                    color: getChangeColor(isProfit ? 12 : -12),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                _buildStat(
                                  "Total P/L",

                                  format(widget.trader.totalProfitLoss),
                                  color: isProfit ? Colors.green : Colors.red,
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: CustomPaint(
                              painter: MinimalPriceChartPainter(
                                prices: widget.trader.prices,
                                lineColor: getChangeColor(widget.trader.roi),
                                gradientColor: getChangeColor(
                                  widget.trader.roi,
                                ),
                              ),
                              size: const Size(double.infinity, 52),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsetsGeometry.all(16),
                  decoration: BoxDecoration(
                    color: RoqquColors.background,
                    border: Border(top: BorderSide(color: RoqquColors.border)),
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      _buildStat("Win Rate", "${widget.trader.winRate}%"),
                      Spacer(),
                      Icon(
                        Icons.info_outline,
                        color: RoqquColors.textSecondary,
                        size: 14,
                      ),
                      _buildStat("AUM", format(widget.trader.aum)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStat(String label, String value, {Color? color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              color: RoqquColors.textSecondary,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.encodeSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: RoqquColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
