import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/providers/database_provider.dart';
import 'package:flutter_expense_tracker_app/views/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await GetStorage.init();
  await DatabaseProvider.initDb();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 1000),
          title: 'Flutter Expence Tracker App',
          theme: Themes.lightTheme,
          themeMode: _themeController.theme,
          darkTheme: Themes.darkTheme,
          home: child,
        );
      },
      child: HomeScreen(),
    );
  }
}
