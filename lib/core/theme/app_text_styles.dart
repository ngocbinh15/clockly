import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class AppTextStyles {
  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: ThemeHelper.isDark ? Colors.white : Colors.black,
  );

  static TextStyle get title => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ThemeHelper.isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.5),
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ThemeHelper.isDark ? Colors.white70 : Colors.black87,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ThemeHelper.isDark ? Colors.white54 : Colors.grey,
  );
}