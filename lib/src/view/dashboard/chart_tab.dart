import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/model/trading_entry.dart';
import 'package:roqqu/src/view/dashboard/trading_entry_card.dart';
import '../../controller/crypto_controller.dart';
import '../widgets/price_chart_painter.dart';

class ChartTab extends StatelessWidget {
  const ChartTab({super.key});

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
                      "Copy trading PNL",
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
                        lineColor: getChangeColor(crypto?.currentPrice ?? 0),
                      ),
                      size: Size(double.infinity, 200),
                    );
                  }),
                ),
              ],
            ),
          ),
          Divider(color: RoqquColors.background, height: 1),
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
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
