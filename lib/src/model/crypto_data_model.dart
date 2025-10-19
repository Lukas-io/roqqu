// ============================================================================
// MODELS
// ============================================================================

class CryptoData {
  final String symbol; // e.g., "BTCUSDT"
  final String name; // e.g., "Bitcoin"
  final double currentPrice;
  final double priceChangePercent24h;
  final double volume24h;
  final double highPrice24h;
  final double lowPrice24h;
  final List<PricePoint> historicalData; // 7-day data
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
      priceChangePercent24h: priceChangePercent24h ??
          this.priceChangePercent24h,
      volume24h: volume24h ?? this.volume24h,
      highPrice24h: highPrice24h ?? this.highPrice24h,
      lowPrice24h: lowPrice24h ?? this.lowPrice24h,
      historicalData: historicalData ?? this.historicalData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class PricePoint {
  final DateTime timestamp;
  final double price;

  PricePoint({
    required this.timestamp,
    required this.price,
  });

  factory PricePoint.fromJson(List<dynamic> json) {
    return PricePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0]),
      price: double.parse(json[4]), // Close price
    );
  }
}

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

// ============================================================================
// CRYPTO SERVICE (REST API)
// ============================================================================

import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  static const String baseUrl = 'https://api.binance.com/api/v3';

  // Fetch 7-day historical data
  Future<List<PricePoint>> fetch7DayHistory(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/klines?symbol=$symbol&interval=1d&limit=7',
        ),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => PricePoint.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load historical data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching 7-day history for $symbol: $e');
      rethrow;
    }
  }

  // Fetch current 24h ticker data
  Future<TickerUpdate> fetch24hTicker(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ticker/24hr?symbol=$symbol'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TickerUpdate.fromJson(data);
      } else {
        throw Exception('Failed to load ticker data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching ticker for $symbol: $e');
      rethrow;
    }
  }
}

// ============================================================================
// CRYPTO CONTROLLER (GetX)
// ============================================================================

import 'dart:async';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoController extends GetxController {
  // Observable state
  final cryptoDataMap = <String, CryptoData>{}.obs;
  final isConnected = false.obs;
  final errorMessage = ''.obs;

  // WebSocket
  late WebSocketChannel _channel;
  late StreamSubscription<dynamic> _streamSubscription;

  // Configuration
  static const List<String> symbols = ['BTC', 'ETH', 'USDT', 'ADA', 'DOGE'];
  static const Map<String, String> symbolNames = {
    'BTC': 'Bitcoin',
    'ETH': 'Ethereum',
    'USDT': 'Tether',
    'ADA': 'Cardano',
    'DOGE': 'Dogecoin',
  };

  final CryptoService _service = CryptoService();
  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;
  static const int _maxReconnectAttempts = 5;

  @override
  void onInit() {
    super.onInit();
    _initializeCrypto();
  }

  Future<void> _initializeCrypto() async {
    // Initialize each crypto with empty data
    for (String symbol in symbols) {
      cryptoDataMap[symbol] = CryptoData(
        symbol: '${symbol}USDT',
        name: symbolNames[symbol] ?? symbol,
        currentPrice: 0,
        priceChangePercent24h: 0,
        volume24h: 0,
        highPrice24h: 0,
        lowPrice24h: 0,
        historicalData: [],
        lastUpdated: DateTime.now(),
      );
    }

    // Fetch initial data and connect to WebSocket
    await _fetchInitialData();
    _connectWebSocket();
  }

  // Fetch 7-day history and initial ticker data
  Future<void> _fetchInitialData() async {
    try {
      for (String symbol in symbols) {
        final fullSymbol = '${symbol}USDT';

        // Fetch historical data
        final history = await _service.fetch7DayHistory(fullSymbol);

        // Fetch initial ticker
        final ticker = await _service.fetch24hTicker(fullSymbol);

        // Update crypto data
        final updated = cryptoDataMap[symbol]!.copyWith(
          currentPrice: ticker.price,
          priceChangePercent24h: ticker.priceChangePercent,
          volume24h: ticker.volume,
          highPrice24h: ticker.highPrice,
          lowPrice24h: ticker.lowPrice,
          historicalData: history,
          lastUpdated: DateTime.now(),
        );

        cryptoDataMap[symbol] = updated;
      }

      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to fetch initial data: $e';
      print('Error in _fetchInitialData: $e');
    }
  }

  // WebSocket connection
  void _connectWebSocket() {
    try {
      // Build combined stream URL for all pairs
      final streams = symbols
          .map((s) => '${s.toLowerCase()}usdt@ticker')
          .join('/');

      final wsUrl = 'wss://stream.binance.com:9443/stream?streams=$streams';

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _streamSubscription = _channel.stream.listen(
        _onWebSocketData,
        onError: _onWebSocketError,
        onDone: _onWebSocketDone,
        cancelOnError: false,
      );

      isConnected.value = true;
      _reconnectAttempts = 0;
      errorMessage.value = '';
      print('✓ WebSocket connected');
    } catch (e) {
      print('✗ WebSocket connection failed: $e');
      errorMessage.value = 'WebSocket connection failed';
      _scheduleReconnect();
    }
  }

  void _onWebSocketData(dynamic message) {
    try {
      final data = json.decode(message);
      final stream = data['stream'] as String;
      final ticker = data['data'] as Map<String, dynamic>;

      // Extract symbol from stream name (e.g., "btcusdt@ticker" -> "BTC")
      final symbol = stream.split('@')[0].replaceAll('usdt', '').toUpperCase();

      if (cryptoDataMap.containsKey(symbol)) {
        final update = TickerUpdate.fromJson(ticker);

        // Update the crypto data
        final current = cryptoDataMap[symbol]!;
        final updated = current.copyWith(
          currentPrice: update.price,
          priceChangePercent24h: update.priceChangePercent,
          volume24h: update.volume,
          highPrice24h: update.highPrice,
          lowPrice24h: update.lowPrice,
          lastUpdated: DateTime.now(),
        );

        cryptoDataMap[symbol] = updated;
      }
    } catch (e) {
      print('Error parsing WebSocket data: $e');
    }
  }

  void _onWebSocketError(error) {
    print('WebSocket error: $error');
    isConnected.value = false;
    errorMessage.value = 'WebSocket error: $error';
    _scheduleReconnect();
  }

  void _onWebSocketDone() {
    print('WebSocket connection closed');
    isConnected.value = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;

      // Exponential backoff: 2s, 4s, 8s, 16s, 32s
      final delay = Duration(
          seconds: (2 * (1 << (_reconnectAttempts - 1))).toInt());

      print('Reconnecting in ${delay
          .inSeconds}s (attempt $_reconnectAttempts/$_maxReconnectAttempts)');

      _reconnectTimer?.cancel();
      _reconnectTimer = Timer(delay, () {
        _connectWebSocket();
      });
    } else {
      errorMessage.value = 'Max reconnection attempts reached';
      print('✗ Max reconnection attempts reached');
    }
  }

  // ============================================================================
  // GETTERS FOR UI/CALCULATIONS
  // ============================================================================

  /// Get single crypto data
  CryptoData? getCrypto(String symbol) => cryptoDataMap[symbol];

  /// Get all cryptos sorted by symbol
  List<CryptoData> getAllCryptos() {
    return symbols
        .map((s) => cryptoDataMap[s])
        .whereType<CryptoData>()
        .toList();
  }

  /// Get current price for a crypto
  double getCurrentPrice(String symbol) {
    return cryptoDataMap[symbol]?.currentPrice ?? 0;
  }

  /// Get 24h percentage change
  double get24hChange(String symbol) {
    return cryptoDataMap[symbol]?.priceChangePercent24h ?? 0;
  }

  /// Get 24h percentage change (color indicator: green if positive, red if negative)
  bool isPositiveChange(String symbol) {
    final change = get24hChange(symbol);
    return change >= 0;
  }

  /// Get 7-day high price
  double get7DayHigh(String symbol) {
    final history = cryptoDataMap[symbol]?.historicalData ?? [];
    if (history.isEmpty) return 0;
    return history.map((p) => p.price).reduce((a, b) => a > b ? a : b);
  }

  /// Get 7-day low price
  double get7DayLow(String symbol) {
    final history = cryptoDataMap[symbol]?.historicalData ?? [];
    if (history.isEmpty) return 0;
    return history.map((p) => p.price).reduce((a, b) => a < b ? a : b);
  }

  /// Get 7-day price change percentage
  double get7DayChangePercent(String symbol) {
    final history = cryptoDataMap[symbol]?.historicalData ?? [];
    if (history.length < 2) return 0;

    final oldPrice = history.first.price;
    final newPrice = history.last.price;

    if (oldPrice == 0) return 0;
    return ((newPrice - oldPrice) / oldPrice) * 100;
  }

  /// Get 7-day average price
  double get7DayAverage(String symbol) {
    final history = cryptoDataMap[symbol]?.historicalData ?? [];
    if (history.isEmpty) return 0;

    final sum = history.fold<double>(0, (sum, p) => sum + p.price);
    return sum / history.length;
  }

  /// Get volatility (7-day standard deviation)
  double get7DayVolatility(String symbol) {
    final history = cryptoDataMap[symbol]?.historicalData ?? [];
    if (history.length < 2) return 0;

    final average = get7DayAverage(symbol);
    final squaredDiffs = history.map((p) =>
    (p.price - average) * (p.price - average));
    final variance = squaredDiffs.reduce((a, b) => a + b) / history.length;

    return variance > 0 ? variance.toStringAsFixed(2).toDouble() : 0;
  }

  /// Get 24h volume
  double get24hVolume(String symbol) {
    return cryptoDataMap[symbol]?.volume24h ?? 0;
  }

  /// Get historical data for charting
  List<PricePoint> getHistoricalData(String symbol) {
    return cryptoDataMap[symbol]?.historicalData ?? [];
  }

  /// Format price to readable string
  String formatPrice(double price) {
    if (price >= 1) {
      return price.toStringAsFixed(2);
    } else if (price > 0) {
      return price.toStringAsFixed(6);
    }
    return '0.00';
  }

  /// Format percentage to readable string
  String formatPercentage(double percent) {
    return percent.toStringAsFixed(2);
  }

  /// Manual refresh historical data
  Future<void> refreshHistoricalData(String symbol) async {
    try {
      final fullSymbol = '${symbol}USDT';
      final history = await _service.fetch7DayHistory(fullSymbol);

      final current = cryptoDataMap[symbol]!;
      final updated = current.copyWith(
        historicalData: history,
        lastUpdated: DateTime.now(),
      );

      cryptoDataMap[symbol] = updated;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to refresh data: $e';
      print('Error refreshing historical data: $e');
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    _channel.sink.close();
    _reconnectTimer?.cancel();
    super.onClose();
  }
}