import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeHelper {
  static RxBool rxIsDark = false.obs;

  static bool get isDark => rxIsDark.value;
  static set isDark(bool val) => rxIsDark.value = val;

  static ThemeMode stringToThemeMode(String? themeStr) {
    if (themeStr == 'dark') return ThemeMode.dark;
    if (themeStr == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }
}
