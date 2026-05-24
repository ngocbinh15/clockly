import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';

void main() {
  test('Should resolve string preferences correctly to ThemeMode', () {
    expect(ThemeHelper.stringToThemeMode('dark'), ThemeMode.dark);
    expect(ThemeHelper.stringToThemeMode('light'), ThemeMode.light);
    expect(ThemeHelper.stringToThemeMode('system'), ThemeMode.system);
    expect(ThemeHelper.stringToThemeMode(null), ThemeMode.system);
    expect(ThemeHelper.stringToThemeMode('invalid'), ThemeMode.system);
  });

  test('Verify baseline AppColors resolve correctly in default light state', () {
    expect(AppColors.primary, const Color(0xFF004AC6));
  });
}
