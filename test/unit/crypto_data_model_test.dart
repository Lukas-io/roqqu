import 'package:flutter_test/flutter_test.dart';
import 'package:roqqu/src/model/crypto_data_model.dart';
import 'package:roqqu/src/model/price_point.dart';

void main() {
  group('CryptoData Model Tests', () {
    late CryptoData cryptoData;

    setUp(() {
      cryptoData = CryptoData(
        symbol: 'BTCUSDT',
        name: 'Bitcoin',
        currentPrice: 50000.0,
        priceChangePercent24h: 5.5,
        volume24h: 1000000.0,
        highPrice24h: 51000.0,
        lowPrice24h: 49000.0,
        historicalData: [
          PricePoint(timestamp: DateTime(2023, 1, 1), price: 45000.0),
          PricePoint(timestamp: DateTime(2023, 1, 2), price: 46000.0),
        ],
        lastUpdated: DateTime(2023, 1, 2),
      );
    });

    test('CryptoData should be created with correct values', () {
      expect(cryptoData.symbol, 'BTCUSDT');
      expect(cryptoData.name, 'Bitcoin');
      expect(cryptoData.currentPrice, 50000.0);
      expect(cryptoData.priceChangePercent24h, 5.5);
      expect(cryptoData.volume24h, 1000000.0);
      expect(cryptoData.highPrice24h, 51000.0);
      expect(cryptoData.lowPrice24h, 49000.0);
      expect(cryptoData.historicalData.length, 2);
      expect(cryptoData.lastUpdated, DateTime(2023, 1, 2));
    });

    test('copyWith should create a new instance with updated values', () {
      final updatedCryptoData = cryptoData.copyWith(
        currentPrice: 55000.0,
        name: 'New Bitcoin',
      );

      // Original should remain unchanged
      expect(cryptoData.currentPrice, 50000.0);
      expect(cryptoData.name, 'Bitcoin');

      // New instance should have updated values
      expect(updatedCryptoData.currentPrice, 55000.0);
      expect(updatedCryptoData.name, 'New Bitcoin');
      // Other values should remain the same
      expect(updatedCryptoData.symbol, 'BTCUSDT');
      expect(updatedCryptoData.priceChangePercent24h, 5.5);
    });

    test('copyWith should preserve unchanged values when not specified', () {
      final updatedCryptoData = cryptoData.copyWith();

      // All values should remain the same
      expect(updatedCryptoData.symbol, cryptoData.symbol);
      expect(updatedCryptoData.name, cryptoData.name);
      expect(updatedCryptoData.currentPrice, cryptoData.currentPrice);
      expect(updatedCryptoData.priceChangePercent24h, cryptoData.priceChangePercent24h);
      expect(updatedCryptoData.volume24h, cryptoData.volume24h);
      expect(updatedCryptoData.highPrice24h, cryptoData.highPrice24h);
      expect(updatedCryptoData.lowPrice24h, cryptoData.lowPrice24h);
      expect(updatedCryptoData.historicalData, cryptoData.historicalData);
      expect(updatedCryptoData.lastUpdated, cryptoData.lastUpdated);
    });
  });

  group('PricePoint Model Tests', () {
    late PricePoint pricePoint;

    setUp(() {
      pricePoint = PricePoint(
        timestamp: DateTime(2023, 1, 1, 12, 0, 0),
        price: 50000.0,
      );
    });

    test('PricePoint should be created with correct values', () {
      expect(pricePoint.timestamp, DateTime(2023, 1, 1, 12, 0, 0));
      expect(pricePoint.price, 50000.0);
    });

    test('fromJson should create PricePoint from JSON', () {
      final json = [
        1672538400000, // timestamp in milliseconds
        "0.00000000",   // open
        "0.00000000",   // high
        "0.00000000",   // low
        "50000.00000000", // close (price)
        "0.00000000",   // volume
        1672542000000, // close time
        "0.00000000",   // quote asset volume
        0,              // number of trades
        "0.00000000",   // taker buy base asset volume
        "0.00000000",   // taker buy quote asset volume
        "0"             // ignore
      ];

      final pricePoint = PricePoint.fromJson(json);
      expect(pricePoint.timestamp, DateTime.fromMillisecondsSinceEpoch(1672538400000));
      expect(pricePoint.price, 50000.0);
    });
  });
}