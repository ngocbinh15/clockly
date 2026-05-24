import 'dart:ui';
import 'package:get/get.dart';

class AppColors {
  static const primary = Color(0xFF004AC6);
  static const third = Color(0xFF594CA7);
  static const fouth = Color(0xFFE53935);

  static Color get secondary => Get.isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
  static Color get background => Get.isDarkMode ? const Color(0xFF121212) : const Color(0xFFF6F6F8);
  static Color get grey => Get.isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  static Color get red => const Color(0xFFDC2626).withValues(alpha: Get.isDarkMode ? 0.3 : 0.5);
  static Color get green => const Color(0xFF16A34A).withValues(alpha: Get.isDarkMode ? 0.3 : 0.5);
  static Color get orange => const Color(0xFFFFB74D).withValues(alpha: Get.isDarkMode ? 0.3 : 0.5);

  static Color get contentDone => Get.isDarkMode ? const Color(0xFF3B82F6) : const Color(0xFF5B8DEF);
  static Color get contentPending => Get.isDarkMode ? const Color(0xFF6366F1) : const Color(0xFF8A84E2);
  static Color get contentLate => Get.isDarkMode ? const Color(0xFFEF4444) : const Color(0xFFFF8FA3);
}