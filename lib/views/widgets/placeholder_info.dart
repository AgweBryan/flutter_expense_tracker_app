import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controllers/home_controller.dart';
import 'package:flutter_expense_tracker_app/views/widgets/show_transaction_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlaceholderInfo extends StatelessWidget {
  const PlaceholderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Get.find<HomeController>().myTransactions.isEmpty
          ? Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/appicon.png'),
                    Text('You have not added an income or expense today!',
                        style: TextStyle(
                          fontSize: 13.sp,
                        )),
                    Text('Add new incomes or expense to track your money',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ))
                  ],
                ),
              ),
            )
          : ShowTransactions(),
    );
  }
}
