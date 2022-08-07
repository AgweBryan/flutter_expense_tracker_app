import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controllers/home_controller.dart';
import 'package:flutter_expense_tracker_app/views/screens/edit_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/transaction_tile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowTransactions extends StatelessWidget {
  ShowTransactions({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _homeController.myTransactions.length,
      itemBuilder: (context, i) {
        final transaction = _homeController.myTransactions[i];
        final bool isIncome = transaction.type == 'Income' ? true : false;
        final text =
            '${_homeController.selectedCurrency.symbol}${transaction.amount}';
        final formatAmount = isIncome ? '+ $text' : '- $text';
        return transaction.date ==
                DateFormat.yMd().format(_homeController.selectedDate)
            ? GestureDetector(
                onTap: () async {
                  await Get.to(() => EditTransactionScreen(tm: transaction));
                  _homeController.getTransactions();
                },
                child: TransactionTile(
                    transaction: transaction,
                    formatAmount: formatAmount,
                    isIncome: isIncome),
              )
            : SizedBox();
      },
    );
  }
}
