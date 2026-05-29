import 'package:clockly/bidings/initial_biding.dart';
import 'package:clockly/core/theme/app_theme.dart';
import 'package:clockly/routes/app_pages.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final ThemeMode initialThemeMode;
  const MyApp({super.key, required this.initialThemeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clockly',
      theme: AppTheme.light,

      initialRoute: AppRoutes.splash,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.dark,
      themeMode: initialThemeMode,
    );
  }
}
