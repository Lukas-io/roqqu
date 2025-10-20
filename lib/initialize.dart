import 'package:get/get.dart';
import 'package:roqqu/src/controller/crypto_controller.dart';
import 'package:roqqu/src/controller/user_controller.dart';

void initialize() {
  Get.put(UserController(), permanent: true);
  Get.put(CryptoController(), permanent: true);
}
