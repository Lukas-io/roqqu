import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/controller/crypto_controller.dart';
import 'package:roqqu/src/core/constants.dart';

import '../../core/theme/color.dart';
import '../../core/utils.dart';
import '../widgets/crypto_pair_avatar.dart';

class ListedCoinsPreviewWidget extends StatelessWidget {
  const ListedCoinsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.find<CryptoController>();
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            children: [
              Text(
                'Listed Coins',
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: RoqquColors.border),
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final entry = controller.cryptoDataMap.entries
                      .toList()[index];

                  final symbol = entry.key;
                  final data = entry.value;
                  final name = entry.value.name;

                  final price = data.currentPrice;
                  final change = data.priceChangePercent24h;

                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 22.0,
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          CryptoPairAvatar(signalPair: symbol, size: 36),
                          Expanded(
                            child: Column(
                              spacing: 4,

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 14,
                                    color: RoqquColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  symbol,
                                  style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 1,

                                    color: RoqquColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 4,
                            children: [
                              Text(
                                format(price),
                                style: GoogleFonts.encodeSans(
                                  fontSize: 14,
                                  color: RoqquColors.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${change.toPrecision(2)}%",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: getChangeColor(change),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: RoqquColors.border, height: 2);
                },
                itemCount: controller.cryptoDataMap.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
