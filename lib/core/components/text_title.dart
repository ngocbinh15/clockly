import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.titleText});

  final String titleText;

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
