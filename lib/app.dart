import 'package:clockly/core/theme/app_theme.dart';
import 'package:clockly/routes/app_pages.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clockly',
      theme: AppTheme.light,

      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}