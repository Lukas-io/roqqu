import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/model/trading_entry.dart';
import 'package:roqqu/src/view/dashboard/trading_entry_card.dart';
import 'package:roqqu/src/view/trader/scatter_chart_painter.dart';
import '../../controller/crypto_controller.dart';
import '../../model/price_point.dart';
import '../widgets/price_chart_painter.dart';

class ChartTab extends StatelessWidget {
  final bool isTrader;

  const ChartTab({super.key, this.isTrader = false});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.find<CryptoController>();

    return Container(
      color: RoqquColors.card,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      isTrader ? "ROI" : "Copy trading PNL",
                      style: GoogleFonts.encodeSans(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: RoqquColors.text,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: RoqquColors.buttonColor,
                        minimumSize: Size.zero,
                        padding: EdgeInsetsGeometry.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '7 days',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: RoqquColors.text,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: RoqquColors.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Obx(() {
                    final crypto = controller.cryptoDataMap["BTC"];
                    return CustomPaint(
                      painter: PriceChartPainter(
                        pricePoints: crypto?.historicalData ?? [],
                        lineColor: getChangeColor(
                          crypto?.priceChangePercent24h ?? 0,
                        ),
                      ),
                      size: Size(double.infinity, 200),
                    );
                  }),
                ),
              ],
            ),
          ),
          if (!isTrader) ...[
            Divider(color: RoqquColors.background, height: 4, thickness: 4),
            Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Row(
                children: [
                  Text(
                    "Trading History",
                    style: GoogleFonts.encodeSans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: RoqquColors.text,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: RoqquColors.buttonColor,
                      minimumSize: Size.zero,
                      padding: EdgeInsetsGeometry.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '7 days',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: RoqquColors.text,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: RoqquColors.text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ...tradingHistory
                .take(3)
                .map((entry) => TradingEntryCard(entry: entry)),
          ] else ...[
            TradingSection(),
          ],
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TradingSection extends StatelessWidget {
  const TradingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(color: RoqquColors.background, height: 4, thickness: 4),
        Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Row(
            children: [
              Text(
                "Assets allocation",
                style: GoogleFonts.encodeSans(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: RoqquColors.text,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: RoqquColors.buttonColor,
                  minimumSize: Size.zero,
                  padding: EdgeInsetsGeometry.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '7 days',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: RoqquColors.text,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: RoqquColors.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Color(0xFFFABE76),
          radius: 92,
          child: CircleAvatar(
            radius: 72,
            backgroundColor: Color(0xFFF7931A),
            child: CircleAvatar(
              backgroundColor: RoqquColors.card,
              radius: 64,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "BTCUSDT",
                      style: TextStyle(fontSize: 12, color: RoqquColors.text),
                    ),
                    Text(
                      '100.00%',
                      style: GoogleFonts.encodeSans(
                        fontSize: 14,
                        color: RoqquColors.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 32),

        Divider(color: RoqquColors.background, height: 4, thickness: 4),
        Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Row(
            children: [
              Text(
                "Holding period",
                style: GoogleFonts.encodeSans(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: RoqquColors.text,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: RoqquColors.buttonColor,
                  minimumSize: Size.zero,
                  padding: EdgeInsetsGeometry.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '7 days',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: RoqquColors.text,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: RoqquColors.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          child: CustomPaint(
            painter: ScatterChartPainter(points: sampleProfitLossPoints),
            size: Size(double.infinity, 200),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            CircleAvatar(backgroundColor: RoqquColors.active, radius: 4),
            Text(
              'Profit',
              style: TextStyle(fontSize: 12, color: RoqquColors.text),
            ),
            SizedBox(width: 4),
            CircleAvatar(backgroundColor: RoqquColors.error, radius: 4),
            Text(
              'Loss',
              style: TextStyle(fontSize: 12, color: RoqquColors.text),
            ),
          ],
        ),
      ],
    );
  }
}
