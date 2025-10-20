import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/copy_trading/initial_avatar.dart';

import '../../core/utils.dart';
import '../../model/copy_trader.dart';
import '../widgets/price_painter.dart';

class CopyTraderCard extends StatefulWidget {
  final CopyTrader trader;

  const CopyTraderCard({super.key, required this.trader});

  @override
  State<CopyTraderCard> createState() => _CopyTraderCardState();
}

class _CopyTraderCardState extends State<CopyTraderCard> {
  final isCopied = false.obs;

  @override
  Widget build(BuildContext context) {
    final isProfit = widget.trader.totalProfitLoss >= 0;

    return Container(
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
                    ),
                    Column(
                      children: [
                        Text(
                          widget.trader.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(children: [Icon]),
                      ],
                    ),
                    Spacer(),
                    Obx(
                      () => InkWell(
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
                    ),
                  ],
                ),
                Text(
                  '${widget.trader.roi.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isProfit ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                CustomPaint(
                  painter: PriceChartPainter(
                    prices: widget.trader.prices,
                    lineColor: getChangeColor(90),
                    gradientColor: getChangeColor(90),
                  ),
                  size: const Size(double.infinity, 52),
                ),
                const SizedBox(height: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat(
                  "Win Rate",
                  "${widget.trader.winRate.toStringAsFixed(1)}%",
                ),
                _buildStat(
                  "Total P/L",
                  (isProfit ? "+" : "") +
                      widget.trader.totalProfitLoss.toStringAsFixed(2),
                  color: isProfit ? Colors.green : Colors.red,
                ),
                _buildStat("AUM", "\$${widget.trader.aum.toStringAsFixed(1)}K"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
