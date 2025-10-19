import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/price_point.dart';
import '../model/ticker_update.dart';

class CryptoService {
  static const String baseUrl = 'https://api.binance.com/api/v3';

  // Fetch 7-day historical data
  Future<List<PricePoint>> fetch7DayHistory(String symbol) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/klines?symbol=$symbol&interval=1d&limit=7'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => PricePoint.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load historical data: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching 7-day history for $symbol: $e');
      rethrow;
    }
  }

  // Fetch current 24h ticker data
  Future<TickerUpdate> fetch24hTicker(String symbol) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ticker/24hr?symbol=$symbol'))
          .timeout(const Duration(seconds: 10));

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
