class PricePoint {
  final DateTime timestamp;
  final double price;

  PricePoint({required this.timestamp, required this.price});

  factory PricePoint.fromJson(List<dynamic> json) {
    return PricePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0]),
      price: double.parse(json[4]), // Close price
    );
  }
}

final List<PricePoint> sampleProfitLossPoints = [
  PricePoint(
    price: 1200,
    timestamp: DateTime.now().subtract(const Duration(hours: 9)),
  ),
  PricePoint(
    price: -500,
    timestamp: DateTime.now().subtract(const Duration(hours: 8)),
  ),
  PricePoint(
    price: 2400,
    timestamp: DateTime.now().subtract(const Duration(hours: 7)),
  ),
  PricePoint(
    price: -1200,
    timestamp: DateTime.now().subtract(const Duration(hours: 6)),
  ),
  PricePoint(
    price: 300,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  PricePoint(
    price: 1800,
    timestamp: DateTime.now().subtract(const Duration(hours: 4)),
  ),
  PricePoint(
    price: -900,
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  PricePoint(
    price: 2700,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  PricePoint(
    price: -1500,
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  PricePoint(price: 3500, timestamp: DateTime.now()),
];
