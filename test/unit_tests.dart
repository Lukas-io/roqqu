// This file imports all unit tests so they can be run together
import 'unit/crypto_controller_test.dart' as crypto_controller_test;
import 'unit/crypto_data_model_test.dart' as crypto_data_model_test;
import 'unit/crypto_service_test.dart' as crypto_service_test;
import 'unit/biometrics_service_test.dart' as biometrics_service_test;

void main() {
  // Run all unit tests
  crypto_controller_test.main();
  crypto_data_model_test.main();
  crypto_service_test.main();
  biometrics_service_test.main();
}