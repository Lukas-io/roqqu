import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';

import '../../core/assets.dart';
import '../../core/theme/color.dart';
import '../../core/utils.dart';
import '../widgets/crypto_pair_avatar.dart';

enum CryptoAsset {
  bitcoin(name: 'Bitcoin', pair: 'BTC', image: RoqquAssets.bitcoinImage),
  ethereum(name: 'Ethereum', pair: 'ETH', image: RoqquAssets.ethereumImage),
  cardano(name: 'Cardano', pair: 'ADA', image: RoqquAssets.cardanoImage),
  doge(name: 'Dogecoin', pair: 'DOGE', image: RoqquAssets.dogeImage),
  tether(name: 'Tether', pair: 'USDT', image: RoqquAssets.tetherImage);

  final String name;
  final String pair;
  final String image;

  const CryptoAsset({
    required this.name,
    required this.pair,
    required this.image,
  });
}

class ListedCoinsPreviewWidget extends StatelessWidget {
  const ListedCoinsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final crypto = CryptoAsset.values[index];
                return InkWell(
                  // onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 22.0,
                    ),
                    child: Row(
                      spacing: 16,
                      children: [
                        CryptoPairAvatar(signalPair: crypto.pair, size: 36),
                        Expanded(
                          child: Column(
                            spacing: 4,

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                crypto.name,
                                style: GoogleFonts.encodeSans(
                                  fontSize: 14,
                                  color: RoqquColors.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                crypto.pair,
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
                              format(90),
                              style: GoogleFonts.encodeSans(
                                fontSize: 14,
                                color: RoqquColors.text,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "-12.0%",
                              style: TextStyle(
                                fontSize: 13,
                                color: getChangeColor(-9.0),
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
              itemCount: CryptoAsset.values.length,
            ),
          ),
        ],
      ),
    );
  }
}
