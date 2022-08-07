import 'package:flutter_expense_tracker_app/models/currency.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/providers/database_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final Rx<double> totalIncome = 0.0.obs;
  final Rx<double> totalExpense = 0.0.obs;
  final Rx<double> totalBalance = 0.0.obs;
  final Rx<double> _totalForSelectedDate = 0.0.obs;

  final Rx<Currency> _selectedCurrency =
      Currency(currency: 'USD', symbol: '\$').obs;
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  final Rx<List<TransactionModel>> _myTransactions =
      Rx<List<TransactionModel>>([]);
  final _box = GetStorage();

  List<TransactionModel> get myTransactions => _myTransactions.value;
  double get totalForSelectedDate => _totalForSelectedDate.value;
  DateTime get selectedDate => _selectedDate.value;
  Currency get selectedCurrency => _selectedCurrency.value;
  Currency get _loadCurrencyFromStorage {
    final result = _box.read('currency');
    if (result == null) {
      return Currency(currency: 'USD', symbol: '\$');
    }
    final Currency formatCurrency = Currency(
        currency: result.toString().split('|')[0],
        symbol: result.toString().split('|')[1]);

    return formatCurrency;
  }

  @override
  void onInit() {
    super.onInit();
    _selectedCurrency.value = _loadCurrencyFromStorage;
    getTransactions();
  }

  updateSelectedCurrency(Currency currency) async {
    _selectedCurrency.value = currency;
    final String formatCurrency = '${currency.currency}|${currency.symbol}';
    await _box.write('currency', formatCurrency);
  }

  getTransactions() async {
    final List<TransactionModel> transactionsFromDB = [];
    List<Map<String, dynamic>> transactions =
        await DatabaseProvider.queryTransaction();
    transactionsFromDB.assignAll(transactions.reversed
        .map((data) => TransactionModel().fromJson(data))
        .toList());
    _myTransactions.value = transactionsFromDB;
    getTotalAmountForPickedDate(transactionsFromDB);
    tracker(transactionsFromDB);
  }

  Future<int> deleteTransaction(String id) async {
    return await DatabaseProvider.deleteTransaction(id);
  }

  Future<int> updateTransaction(TransactionModel transactionModel) async {
    return await DatabaseProvider.updateTransaction(transactionModel);
  }

  updateSelectedDate(DateTime date) {
    _selectedDate.value = date;
    getTransactions();
  }

  getTotalAmountForPickedDate(List<TransactionModel> tm) {
    if (tm.isEmpty) {
      return;
    }
    double total = 0;
    for (TransactionModel transactionModel in tm) {
      if (transactionModel.date == DateFormat.yMd().format(selectedDate)) {
        if (transactionModel.type == 'Income') {
          total += double.parse(transactionModel.amount!);
        } else {
          total -= double.parse(transactionModel.amount!);
        }
      }
    }
    _totalForSelectedDate.value = total;
  }

  tracker(List<TransactionModel> tm) {
    if (tm.isEmpty) {
      return;
    }
    double expense = 0;
    double income = 0;
    double balance = 0;

    for (TransactionModel transactionModel in tm) {
      if (transactionModel.type == 'Income') {
        income += double.parse(transactionModel.amount!);
      } else {
        expense += double.parse(transactionModel.amount!);
      }
    }
    balance = income - expense;
    totalIncome.value = income;
    totalExpense.value = expense;
    totalBalance.value = balance;
  }
}
