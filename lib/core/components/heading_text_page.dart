import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../utils/theme_helper.dart';

class HeadingTextPage extends StatelessWidget {
  HeadingTextPage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: isDark ? Colors.white : Colors.black87,
        ),
      );
    });
  }
}
