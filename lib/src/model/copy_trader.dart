class CopyTrader {
  final String name;
  final double roi;
  final double winRate;
  final double totalProfitLoss;
  final List<double> prices;
  final double aum;
  final int copiers;

  CopyTrader({
    required this.name,
    required this.roi,
    required this.winRate,
    required this.totalProfitLoss,
    required this.prices,
    required this.aum,
    required this.copiers,
  });
}

final List<CopyTrader> traders = [
  CopyTrader(
    name: "AlphaEdge",
    roi: 42.3,
    winRate: 76.4,
    totalProfitLoss: 12500,
    prices: [100, 110, 130, 128, 145, 160, 175],
    aum: 95.2,
    copiers: 3420,
  ),
  CopyTrader(
    name: "Zen Capital",
    roi: 25.8,
    winRate: 68.1,
    totalProfitLoss: 7400,
    prices: [100, 102, 108, 112, 120, 118, 130],
    aum: 60.4,
    copiers: 1890,
  ),
  CopyTrader(
    name: "NovaInvest",
    roi: -8.4,
    winRate: 43.6,
    totalProfitLoss: -2500,
    prices: [100, 98, 95, 90, 87, 92, 88],
    aum: 22.1,
    copiers: 420,
  ),
  CopyTrader(
    name: "Skyline Traders",
    roi: 63.2,
    winRate: 81.7,
    totalProfitLoss: 18200,
    prices: [100, 115, 130, 150, 170, 200, 210],
    aum: 120.9,
    copiers: 5780,
  ),
  CopyTrader(
    name: "Horizon Alpha",
    roi: 15.5,
    winRate: 59.3,
    totalProfitLoss: 3100,
    prices: [100, 105, 108, 110, 115, 118, 122],
    aum: 48.6,
    copiers: 1330,
  ),
  CopyTrader(
    name: "LunaGrowth",
    roi: 37.9,
    winRate: 71.0,
    totalProfitLoss: 9200,
    prices: [100, 107, 115, 130, 128, 140, 150],
    aum: 78.3,
    copiers: 2675,
  ),
  CopyTrader(
    name: "Titan Fund",
    roi: 5.4,
    winRate: 52.8,
    totalProfitLoss: 800,
    prices: [100, 102, 104, 101, 103, 107, 105],
    aum: 33.5,
    copiers: 820,
  ),
];
