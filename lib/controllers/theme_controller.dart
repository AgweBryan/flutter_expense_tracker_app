import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final Rx<Color> _color = Colors.white.obs;
  final _box = GetStorage();
  final _key = 'isDarkMode';

  Color get color => _color.value;

  @override
  void onInit() {
    super.onInit();
    _color.value = _loadThemeFromBox ? Colors.white : Colors.black;
  }

  ThemeMode get theme => _loadThemeFromBox ? ThemeMode.dark : ThemeMode.light;
  bool get _loadThemeFromBox => _box.read(_key) ?? false;

  switchTheme() async {
    Get.changeThemeMode(theme);
    _color.value = _loadThemeFromBox ? Colors.white : blackClr;
    await _box.write(_key, !_loadThemeFromBox);
  }
}
