import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/controller/crypto_controller.dart';
import 'package:roqqu/src/model/crypto_data_model.dart';
import 'package:roqqu/src/model/price_point.dart';

void main() {
  group('CryptoController Tests', () {
    late CryptoController cryptoController;

    setUp(() {
      Get.testMode = true;
      cryptoController = CryptoController();
    });

    tearDown(() {
      cryptoController.dispose();
    });

    test('initial state should be correct', () {
      expect(cryptoController.cryptoDataMap.isEmpty, true);
      expect(cryptoController.isConnected.value, false);
      expect(cryptoController.errorMessage.value, '');
    });

    test('symbols list should contain expected values', () {
      expect(CryptoController.symbols, ['BTC', 'ETH', 'ADA', 'DOGE']);
    });

    test('symbolNames map should contain expected values', () {
      expect(CryptoController.symbolNames['BTC'], 'Bitcoin');
      expect(CryptoController.symbolNames['ETH'], 'Ethereum');
      expect(CryptoController.symbolNames['ADA'], 'Cardano');
      expect(CryptoController.symbolNames['DOGE'], 'Dogecoin');
    });

    test('getCrypto should return null for non-existent symbol', () {
      expect(cryptoController.getCrypto('NONEXISTENT'), null);
    });

    test('formatPercentage should format correctly', () {
      expect(cryptoController.formatPercentage(12.345), '12.35');
      expect(cryptoController.formatPercentage(-5.678), '-5.68');
      expect(cryptoController.formatPercentage(0), '0.00');
    });

    group('Crypto Calculations Tests', () {
      setUp(() {
        // Initialize with sample data
        cryptoController.cryptoDataMap['BTC'] = CryptoData(
          symbol: 'BTCUSDT',
          name: 'Bitcoin',
          currentPrice: 50000,
          priceChangePercent24h: 5.5,
          volume24h: 1000000,
          highPrice24h: 51000,
          lowPrice24h: 49000,
          historicalData: [
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 7)), price: 45000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 6)), price: 46000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 5)), price: 47000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 4)), price: 48000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 3)), price: 49000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 2)), price: 50000),
            PricePoint(timestamp: DateTime.now().subtract(const Duration(days: 1)), price: 51000),
            PricePoint(timestamp: DateTime.now(), price: 50000),
          ],
          lastUpdated: DateTime.now(),
        );
      });

      test('getCurrentPrice should return correct value', () {
        expect(cryptoController.getCurrentPrice('BTC'), 50000);
      });

      test('get24hChange should return correct value', () {
        expect(cryptoController.get24hChange('BTC'), 5.5);
      });

      test('isPositiveChange should return correct boolean', () {
        expect(cryptoController.isPositiveChange('BTC'), true);
        
        // Test negative change
        cryptoController.cryptoDataMap['BTC'] = 
            cryptoController.getCrypto('BTC')!.copyWith(priceChangePercent24h: -2.5);
        expect(cryptoController.isPositiveChange('BTC'), false);
      });

      test('get7DayHigh should return correct value', () {
        expect(cryptoController.get7DayHigh('BTC'), 51000);
      });

      test('get7DayLow should return correct value', () {
        expect(cryptoController.get7DayLow('BTC'), 45000);
      });

      test('get7DayChangePercent should calculate correctly', () {
        // From 45000 to 50000 = 11.11% increase
        expect(cryptoController.get7DayChangePercent('BTC'), closeTo(11.11, 0.01));
      });

      test('get7DayAverage should calculate correctly', () {
        // Average of [45000, 46000, 47000, 48000, 49000, 50000, 51000, 50000] = 48250
        expect(cryptoController.get7DayAverage('BTC'), 48250);
      });

      test('get24hVolume should return correct value', () {
        expect(cryptoController.get24hVolume('BTC'), 1000000);
      });

      test('getHistoricalData should return correct data', () {
        expect(cryptoController.getHistoricalData('BTC').length, 8);
      });
    });
  });
}