import 'package:clockly/core/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz_data;

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final results = await Future.wait([
    dotenv.load(fileName: ".env"),
    SharedPreferences.getInstance(),
  ]);

  final prefs = results[1] as SharedPreferences;

  await Supabase.initialize(
    url: dotenv.env['URL_SUPABASE'] ?? '',
    anonKey: dotenv.env['ANON_KEY'] ?? '',
  );

  tz_data.initializeTimeZones();

  final initialThemeMode = await ThemeHelper.init(prefs);

  runApp(MyApp(initialThemeMode: initialThemeMode));
}
