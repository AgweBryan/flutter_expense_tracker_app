import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double percentage;
  final bool isExpense;
  Bar({
    Key? key,
    required this.isExpense,
    required this.label,
    required this.totalAmount,
    required this.percentage,
  }) : super(key: key);
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
                child: FittedBox(
                  child: Text(
                      '${_homeController.selectedCurrency.symbol}${totalAmount.toStringAsFixed(0)}'),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 100.h,
                width: 20.w,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                      // border: Border.all(color: primaryColor,width: 2.0.w),
                      borderRadius: BorderRadius.circular(20.r),
                      color: Get.isDarkMode
                          ? Colors.grey.shade900
                          : Colors.grey.shade100,
                    )),
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: isExpense ? pinkClr : primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(label),
            ],
          ),
        ));
  }
}
