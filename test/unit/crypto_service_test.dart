import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:roqqu/src/service/crypto_service.dart';
import 'package:roqqu/src/service/api_client.dart';
import 'package:roqqu/src/model/price_point.dart';
import 'package:roqqu/src/model/ticker_update.dart';

// Generate mock classes
@GenerateMocks([ApiClient, Dio])
import 'crypto_service_test.mocks.dart';

void main() {
  group('CryptoService Tests', () {
    late CryptoService cryptoService;
    late MockApiClient mockApiClient;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      mockApiClient = MockApiClient();
      when(mockApiClient.dio).thenReturn(mockDio);
      cryptoService = CryptoService(apiClient: mockApiClient);
    });

    test('fetchDayHistory should return correct data', () async {
      // Mock response data
      final mockResponse = Response(
        data: [
          [1672538400000, "0.00000000", "0.00000000", "0.00000000", "50000.00000000", "0.00000000", 1672542000000, "0.00000000", 0, "0.00000000", "0.00000000", "0"],
          [1672624800000, "0.00000000", "0.00000000", "0.00000000", "51000.00000000", "0.00000000", 1672628400000, "0.00000000", 0, "0.00000000", "0.00000000", "0"]
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/klines'),
      );

      when(mockDio.get(
        '/klines',
        queryParameters: {'symbol': 'BTCUSDT', 'interval': '30m', 'limit': 48},
      )).thenAnswer((_) async => mockResponse);

      final result = await cryptoService.fetchDayHistory('BTCUSDT');
      
      expect(result, isA<List<PricePoint>>());
      expect(result.length, 2);
      expect(result[0].price, 50000.0);
      expect(result[1].price, 51000.0);
    });

    test('fetch24hTicker should return correct data', () async {
      // Mock response data - using the correct keys that TickerUpdate.fromJson expects
      final mockResponse = Response(
        data: {
          's': 'BTCUSDT',  // symbol key
          'c': '50000.00000000',  // current price
          'p': '2500.00000000',   // price change
          'P': '5.26',            // price change percent
          'h': '51000.00000000',  // high price
          'l': '47000.00000000',  // low price
          'v': '1000.00000000',   // volume
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/ticker/24hr'),
      );

      when(mockDio.get(
        '/ticker/24hr',
        queryParameters: {'symbol': 'BTCUSDT'},
      )).thenAnswer((_) async => mockResponse);

      final result = await cryptoService.fetch24hTicker('BTCUSDT');
      
      expect(result, isA<TickerUpdate>());
      expect(result.symbol, 'BTCUSDT');
      expect(result.price, 50000.0);
      expect(result.priceChange, 2500.0);
      expect(result.priceChangePercent, 5.26);
      expect(result.volume, 1000.0);
      expect(result.highPrice, 51000.0);
      expect(result.lowPrice, 47000.0);
    });

    test('fetchDayHistory should throw exception on API error', () async {
      when(mockDio.get(
        '/klines',
        queryParameters: {'symbol': 'BTCUSDT', 'interval': '30m', 'limit': 48},
      )).thenThrow(DioException(
        error: 'Network error',
        requestOptions: RequestOptions(path: '/klines'),
      ));

      expect(
        () => cryptoService.fetchDayHistory('BTCUSDT'),
        throwsA(isA<DioException>()),
      );
    });

    test('fetch24hTicker should throw exception on API error', () async {
      when(mockDio.get(
        '/ticker/24hr',
        queryParameters: {'symbol': 'BTCUSDT'},
      )).thenThrow(DioException(
        error: 'Network error',
        requestOptions: RequestOptions(path: '/ticker/24hr'),
      ));

      expect(
        () => cryptoService.fetch24hTicker('BTCUSDT'),
        throwsA(isA<DioException>()),
      );
    });
  });
}