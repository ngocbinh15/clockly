import 'package:clockly/core/services/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'app.dart';
import 'core/services/auth_service.dart';
import 'features/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await NotificationService.init();

  await Supabase.initialize(
    url: 'https://ymkcbkaovbltevxozawe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlta2Nia2FvdmJsdGV2eG96YXdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgyMzEzOTMsImV4cCI6MjA5MzgwNzM5M30.DCWuPfgdD0Ql-HUzKa1SNnCKWVvDrR3rpun1H1Aenc0',
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await Get.putAsync<AppInfoService>(
        () => AppInfoService().init(),
  );

  Get.put(AuthService());
  runApp(const MyApp());
}