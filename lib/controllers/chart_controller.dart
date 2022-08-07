import 'package:get/get.dart';

class ChartController extends GetxController {
  final Rx<String> _transactionType = ''.obs;
  final Rx<bool> isExpense = false.obs;
  String get transactionType => _transactionType.value;

  changeTransactionType(String tt) {
    _transactionType.value = tt;
    isExpense.value = tt == 'Income' ? false : true;
  }
}
