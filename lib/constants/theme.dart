import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightModeScaffoldBgCle,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkModeScaffoldBgClr,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  TextStyle get subHeadingTextStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey,
      );

  TextStyle get headingTextStyle => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titleStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      );
  TextStyle get subTitleStyle => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade600,
      );

  TextStyle get labelStyle => TextStyle(
        fontSize: 13.sp,
        color: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade600,
      );
}
