import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final bool isIncome;
  final String formatAmount;

  TransactionTile({
    Key? key,
    required this.transaction,
    required this.formatAmount,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: transaction.image!.isEmpty
          ? CircleAvatar(
              // radius: 16.r,
              backgroundColor: isIncome
                  ? Colors.green.withOpacity(.3)
                  : Colors.red.withOpacity(.3),
              child: Icon(
                isIncome
                    ? Icons.keyboard_double_arrow_up
                    : Icons.keyboard_double_arrow_down,
                color: isIncome ? greenClr : redClr,
              ),
            )
          : CircleAvatar(backgroundImage: FileImage(File(transaction.image!))),
      title: Text(
        transaction.name!,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Category: ${transaction.category}',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Text(
            formatAmount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isIncome ? greenClr : redClr,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            transaction.time!,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
