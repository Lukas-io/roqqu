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
