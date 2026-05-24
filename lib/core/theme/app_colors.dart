import 'dart:ui';
import 'package:clockly/core/utils/theme_helper.dart';

class AppColors {
  static const primary = Color(0xFF004AC6);
  static const third = Color(0xFF594CA7);
  static const fouth = Color(0xFFE53935);

  static Color get secondary => ThemeHelper.isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
  static Color get background => ThemeHelper.isDark ? const Color(0xFF121212) : const Color(0xFFF6F6F8);
  static Color get grey => ThemeHelper.isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  static Color get red => const Color(0xFFDC2626).withValues(alpha: ThemeHelper.isDark ? 0.3 : 0.5);
  static Color get green => const Color(0xFF16A34A).withValues(alpha: ThemeHelper.isDark ? 0.3 : 0.5);
  static Color get orange => const Color(0xFFFFB74D).withValues(alpha: ThemeHelper.isDark ? 0.3 : 0.5);

  static Color get contentDone => ThemeHelper.isDark ? const Color(0xFF3B82F6) : const Color(0xFF5B8DEF);
  static Color get contentPending => ThemeHelper.isDark ? const Color(0xFF6366F1) : const Color(0xFF8A84E2);
  static Color get contentLate => ThemeHelper.isDark ? const Color(0xFFEF4444) : const Color(0xFFFF8FA3);
}