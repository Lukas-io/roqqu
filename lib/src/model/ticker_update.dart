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
    return TickerUpdate(
      symbol: (json['s'] as String).toUpperCase(),
      price: double.parse(json['c']),
      priceChange: double.parse(json['p']),
      priceChangePercent: double.parse(json['P']),
      highPrice: double.parse(json['h']),
      lowPrice: double.parse(json['l']),
      volume: double.parse(json['v']),
      timestamp: DateTime.now(),
    );
  }
}
