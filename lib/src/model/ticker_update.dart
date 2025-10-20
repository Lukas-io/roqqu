class TickerUpdate {
  final String symbol;
  final double price;
  final double priceChange;
  final double priceChangePercent;
  final double highPrice;
  final double lowPrice;
  final double volume;
  final DateTime timestamp;

  TickerUpdate({
    required this.symbol,
    required this.price,
    required this.priceChange,
    required this.priceChangePercent,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
    required this.timestamp,
  });

  factory TickerUpdate.fromJson(Map<String, dynamic> json) {
    double safeParse(dynamic value, [double fallback = 0.0]) {
      if (value == null) return fallback;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? fallback;
    }

    return TickerUpdate(
      symbol: (json['s'] ?? '').toString().toUpperCase(),
      price: safeParse(json['c']),
      priceChange: safeParse(json['p']),
      priceChangePercent: safeParse(json['P']),
      highPrice: safeParse(json['h']),
      lowPrice: safeParse(json['l']),
      volume: safeParse(json['v']),
      timestamp: DateTime.now(),
    );
  }
}
