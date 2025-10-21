import 'package:get/get.dart';
import 'package:roqqu/src/model/copy_trader.dart';

class UserController extends GetxController {
  final RxDouble _balance = 1207.32.obs;
  final showBalance = true.obs;

  void toggleBalanceVisibility() {
    showBalance.value = !showBalance.value;
  }

  void copyTrader({required CopyTrader trader, required double amount}) {
    _balance.value -= amount;
  }

  double get balance => _balance.value;

  double get balanceFraction => _balance.value - _balance.value.floorToDouble();
}
