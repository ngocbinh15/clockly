import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitle extends StatelessWidget {
  TextTitle({super.key, required this.titleText});

  String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: GoogleFonts.inter(
        color: Color(0xFF64748B),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),  
      textAlign: TextAlign.center,
    );
  }
}
