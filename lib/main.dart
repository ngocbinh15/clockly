import 'package:clockly/core/services/ai_service.dart';
import 'package:clockly/core/services/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL_SUPABASE'] ?? '',
    anonKey: dotenv.env['ANON_KEY'] ?? '',
  );

  print(dotenv.env['ANON_KEY']);
  print(" DKJHSKHKDHKJ\n");
  print(dotenv.env['URL_SUPABASE']);

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

  Get.put (AiService());
  runApp(const MyApp());
}