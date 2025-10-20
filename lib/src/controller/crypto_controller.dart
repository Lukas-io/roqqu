import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/crypto_data_model.dart';
import '../model/price_point.dart';
import '../model/ticker_update.dart';
import '../service/crypto_service.dart';

class CryptoController extends GetxController {
  // Observable state
  final cryptoDataMap = <String, CryptoData>{}.obs;
  final isConnected = false.obs;
  final errorMessage = ''.obs;

  // WebSocket
  late WebSocketChannel _channel;
  late StreamSubscription<dynamic> _streamSubscription;

  // Configuration
  static const List<String> symbols = ['BTC', 'ETH', 'ADA', 'DOGE'];
  static const Map<String, String> symbolNames = {
    'BTC': 'Bitcoin',
    'ETH': 'Ethereum',
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
      await Future.wait(
        symbols.map((symbol) async {
          final fullSymbol = '${symbol}USDT';
          final history = await _service.fetchDayHistory(fullSymbol);
          final ticker = await _service.fetch24hTicker(fullSymbol);

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

          update(); // UI updates as each Future completes
        }),
      );

      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to fetch initial data: $e';
      log('Error in _fetchInitialData: $e');
    }
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // WebSocket connection
  void _connectWebSocket() async {
    if (!await _hasInternet()) {
      errorMessage.value = 'No internet connection';
      log('✗ No internet, cannot connect to WebSocket.');
      _scheduleReconnect();
      return;
    }

    log("Has internet");
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
      log('✓ WebSocket connected');
    } catch (e) {
      log('✗ WebSocket connection failed: $e');
      errorMessage.value = 'WebSocket connection failed';
      _scheduleReconnect();
    }
  }

  void _onWebSocketData(dynamic message) {
    try {
      final data = message is String ? json.decode(message) : message;

      if (data is! Map<String, dynamic>) return;
      final stream = data['stream'] as String;
      final ticker = data['data'] as Map<String, dynamic>;

      // Extract symbol from stream name (e.g., "btcusdt@ticker" -> "BTC")
      final symbol = stream.split('@')[0].replaceAll('usdt', '').toUpperCase();

      if (!cryptoDataMap.containsKey(symbol)) return;

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
    } catch (e) {
      log('Error parsing WebSocket data: $e');
    }
  }

  void _onWebSocketError(error) {
    log('WebSocket error: $error');
    isConnected.value = false;
    errorMessage.value = 'WebSocket error: $error';
    _scheduleReconnect();
  }

  void _onWebSocketDone() {
    log('WebSocket connection closed');
    isConnected.value = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;

      // Exponential backoff: 2s, 4s, 8s, 16s, 32s
      final delay = Duration(
        seconds: (2 * (1 << (_reconnectAttempts - 1))).toInt(),
      );

      log(
        'Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempts/$_maxReconnectAttempts)',
      );

      _reconnectTimer?.cancel();
      _reconnectTimer = Timer(delay, () {
        _connectWebSocket();
      });
    } else {
      errorMessage.value = 'Max reconnection attempts reached';
      log('✗ Max reconnection attempts reached');
    }
  }

  // ===========================================================================
  // GETTERS FOR UI/CALCULATIONS
  // ===========================================================================

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
    final squaredDiffs = history.map(
      (p) => (p.price - average) * (p.price - average),
    );
    final variance = squaredDiffs.reduce((a, b) => a + b) / history.length;

    return variance > 0 ? double.tryParse(variance.toStringAsFixed(2)) ?? 0 : 0;
  }

  /// Get 24h volume
  double get24hVolume(String symbol) {
    return cryptoDataMap[symbol]?.volume24h ?? 0;
  }

  /// Get historical data for charting
  List<PricePoint> getHistoricalData(String symbol) {
    return cryptoDataMap[symbol]?.historicalData ?? [];
  }

  /// Format percentage to readable string
  String formatPercentage(double percent) {
    return percent.toStringAsFixed(2);
  }

  /// Manual refresh historical data
  Future<void> refreshHistoricalData(String symbol) async {
    try {
      final fullSymbol = '${symbol}USDT';
      final history = await _service.fetchDayHistory(fullSymbol);

      final current = cryptoDataMap[symbol]!;
      final updated = current.copyWith(
        historicalData: history,
        lastUpdated: DateTime.now(),
      );

      cryptoDataMap[symbol] = updated;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to refresh data: $e';
      log('Error refreshing historical data: $e');
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
