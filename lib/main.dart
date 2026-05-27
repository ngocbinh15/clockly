import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:clockly/core/services/ai_service.dart';
import 'package:clockly/core/services/app_info_service.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:quick_settings/quick_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/services/auth_service.dart';

@pragma('vm:entry-point')
Tile onTileClicked(Tile tile) {
  const intent = AndroidIntent(
    action: 'action_view',
    data: 'clockly://addtask',
    package: 'vn.edu.ntu.clockly.clockly',
    flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
  );

  intent.launch();

  tile.tileStatus = TileStatus.inactive;
  tile.label = "New Task";

  return tile;
}

@pragma('vm:entry-point')
Tile onTileAdded(Tile tile) {
  tile.label = "New Task";
  tile.tileStatus = TileStatus.inactive;
  return tile;
}

@pragma('vm:entry-point')
void onTileRemoved() {
  debugPrint("Người dùng đã gỡ Tile Clockly");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  QuickSettings.setup(
    onTileClicked: onTileClicked,
    onTileAdded: onTileAdded,
    onTileRemoved: onTileRemoved,
  );

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL_SUPABASE'] ?? '',
    anonKey: dotenv.env['ANON_KEY'] ?? '',
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final savedThemeStr = prefs.getString('theme_mode');
  final initialThemeMode = ThemeHelper.stringToThemeMode(savedThemeStr);

  // Set static isDark variable for global non-context colors
  if (initialThemeMode == ThemeMode.dark) {
    ThemeHelper.isDark = true;
  } else if (initialThemeMode == ThemeMode.light) {
    ThemeHelper.isDark = false;
  } else {
    ThemeHelper.isDark =
        (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark);
  }

  await Get.putAsync<AppInfoService>(() => AppInfoService().init());

  Get.put(AuthService());

  Get.put(AiService());
  runApp(MyApp(initialThemeMode: initialThemeMode));
}
