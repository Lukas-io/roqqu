import 'package:flutter/material.dart';

import '../../core/assets.dart';

class CryptoPairAvatar extends StatelessWidget {
  final String signalPair;
  final double size;
  final BoxFit fit;
  final Color? backgroundColor;

  const CryptoPairAvatar({
    super.key,
    required this.signalPair,
    this.size = 40,
    this.fit = BoxFit.cover,
    this.backgroundColor,
  });

  /// Maps symbol prefix to the correct asset image
  String _getImageForPair(String pair) {
    final upper = pair.toUpperCase();
    if (upper.startsWith('BTC')) return RoqquAssets.bitcoinImage;
    if (upper.startsWith('ETH')) return RoqquAssets.ethereumImage;
    if (upper.startsWith('ADA')) return RoqquAssets.cardanoImage;
    if (upper.startsWith('DOGE')) return RoqquAssets.dogeImage;
    if (upper.startsWith('USDT') || upper.contains('USDT')) {
      return RoqquAssets.tetherImage;
    }
    return RoqquAssets.bitcoinImage; // default fallback
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.grey.shade200,
        image: DecorationImage(
          image: AssetImage(_getImageForPair(signalPair)),
          fit: fit,
        ),
      ),
    );
  }
}
