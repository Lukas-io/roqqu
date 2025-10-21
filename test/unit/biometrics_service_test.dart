import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:roqqu/src/service/biometrics_service.dart';

// Generate mock classes
@GenerateMocks([LocalAuthentication])
import 'biometrics_service_test.mocks.dart';

void main() {
  group('BiometricsService Tests', () {
    late BiometricsService biometricsService;

    setUp(() {
      biometricsService = BiometricsService();
    });

    test('isBiometricsAvailable should return boolean', () async {
      // This test will return false in a test environment
      final result = await biometricsService.isBiometricsAvailable();
      expect(result, isA<bool>());
    });

    test('isDeviceSupported should return boolean', () async {
      // This test will return false in a test environment
      final result = await biometricsService.isDeviceSupported();
      expect(result, isA<bool>());
    });

    test('authenticate should return BiometricAuthResult', () async {
      // This test will return a failure result in a test environment
      final result = await biometricsService.authenticate(localizedReason: 'Test authentication');
      expect(result, isA<BiometricAuthResult>());
      expect(result.success, false); // Will fail in test environment
    });
  });
}