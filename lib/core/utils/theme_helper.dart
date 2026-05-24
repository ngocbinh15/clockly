import 'package:flutter/material.dart';

class ThemeHelper {
  static bool isDark = false;

  static ThemeMode stringToThemeMode(String? themeStr) {
    if (themeStr == 'dark') return ThemeMode.dark;
    if (themeStr == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }
}
