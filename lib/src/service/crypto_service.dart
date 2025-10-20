import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/price_point.dart';
import '../model/ticker_update.dart';
import 'api_client.dart';

class CryptoService {
  final ApiClient _api = ApiClient();

  Future<List<PricePoint>> fetchDayHistory(String symbol) async {
    try {
      final response = await _api.dio.get(
        '/klines',
        queryParameters: {'symbol': symbol, 'interval': '30m', 'limit': 48},
      );

      final List<dynamic> data = response.data;
      return data.map((e) => PricePoint.fromJson(e)).toList();
    } on DioException catch (e) {
      log('Error fetching day history for $symbol: ${e.message}');
      rethrow;
    }
  }

  Future<TickerUpdate> fetch24hTicker(String symbol) async {
    try {
      final response = await _api.dio.get(
        '/ticker/24hr',
        queryParameters: {'symbol': symbol},
      );

      return TickerUpdate.fromJson(response.data);
    } on DioException catch (e) {
      log('Error fetching ticker for $symbol: ${e.message}');
      rethrow;
    }
  }
}
