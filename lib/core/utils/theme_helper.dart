import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeHelper {
  static RxBool rxIsDark = false.obs;

  static bool get isDark => rxIsDark.value;
  static set isDark(bool val) => rxIsDark.value = val;

  static Future<ThemeMode> init(SharedPreferences prefs) async {
    final savedThemeStr = prefs.getString('theme_mode');
    final themeMode = stringToThemeMode(savedThemeStr);

    if (themeMode == ThemeMode.dark) {
      isDark = true;
    } else if (themeMode == ThemeMode.light) {
      isDark = false;
    } else {
      isDark =
          (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark);
    }

    return themeMode;
  }

  static ThemeMode stringToThemeMode(String? themeStr) {
    if (themeStr == 'dark') return ThemeMode.dark;
    if (themeStr == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }
}
