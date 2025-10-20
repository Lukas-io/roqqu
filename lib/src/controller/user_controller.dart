import 'package:get/get.dart';

class UserController extends GetxController {
  final RxDouble _balance = 1207.32.obs;
  final showBalance = true.obs;

  void toggleBalanceVisibility() {
    showBalance.value = !showBalance.value;
  }

  double get balance => _balance.value;

  double get balanceFraction => _balance.value - _balance.value.floorToDouble();
}
