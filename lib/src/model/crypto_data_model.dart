import 'package:roqqu/src/model/price_point.dart';

class CryptoData {
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChangePercent24h;
  final double volume24h;
  final double highPrice24h;
  final double lowPrice24h;
  final List<PricePoint> historicalData;
  final DateTime lastUpdated;

  CryptoData({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChangePercent24h,
    required this.volume24h,
    required this.highPrice24h,
    required this.lowPrice24h,
    required this.historicalData,
    required this.lastUpdated,
  });

  // Create a copy with updated fields
  CryptoData copyWith({
    String? symbol,
    String? name,
    double? currentPrice,
    double? priceChangePercent24h,
    double? volume24h,
    double? highPrice24h,
    double? lowPrice24h,
    List<PricePoint>? historicalData,
    DateTime? lastUpdated,
  }) {
    return CryptoData(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChangePercent24h:
          priceChangePercent24h ?? this.priceChangePercent24h,
      volume24h: volume24h ?? this.volume24h,
      highPrice24h: highPrice24h ?? this.highPrice24h,
      lowPrice24h: lowPrice24h ?? this.lowPrice24h,
      historicalData: historicalData ?? this.historicalData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
