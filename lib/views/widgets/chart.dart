import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/views/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> myTransactions;
  final bool isExpense;
  Chart({Key? key, required this.isExpense, required this.myTransactions})
      : super(key: key);

  List<String> get weekDays {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));
      return DateFormat.E().format(weekDay)[0];
    }).reversed.toList();
  }

  List<Map<String, dynamic>> get groupedExpenseTx {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));

      double totalSum = 0;
      for (var tm in myTransactions) {
        if (tm.date == DateFormat.yMd().format(weekDay)) {
          if (tm.type == 'Expense') {
            totalSum += double.parse(tm.amount!);
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  List<Map<String, dynamic>> get groupedIncomeTx {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));

      double totalSum = 0;
      for (var tm in myTransactions) {
        if (tm.date == DateFormat.yMd().format(weekDay)) {
          if (tm.type == 'Income') {
            totalSum += double.parse(tm.amount!);
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalExpense {
    return groupedExpenseTx.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get totalIncome {
    return groupedIncomeTx.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _displayChart(),
    );
  }

  List<Bar> _displayChart() {
    if (isExpense) {
      if (myTransactions.any((element) => element.type == 'Expense')) {
        return groupedExpenseTx.map((data) {
          return Bar(
              isExpense: isExpense,
              label: data['day'],
              totalAmount: data['amount'],
              percentage: data['amount'] / totalExpense);
        }).toList();
      } else {
        return weekDays
            .map((day) =>
                Bar(isExpense: true, label: day, totalAmount: 0, percentage: 0))
            .toList();
      }
    } else {
      if (myTransactions.any((element) => element.type == 'Income')) {
        groupedIncomeTx.map((data) {
          return Bar(
              isExpense: isExpense,
              label: data['day'],
              totalAmount: data['amount'],
              percentage: data['amount'] / totalExpense);
        }).toList();
      } else {
        return weekDays
            .map((day) =>
                Bar(isExpense: true, label: day, totalAmount: 0, percentage: 0))
            .toList();
      }
    }
    return weekDays
        .map((day) =>
            Bar(isExpense: true, label: day, totalAmount: 0, percentage: 0))
        .toList();
  }
}
