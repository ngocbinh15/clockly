import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingTextPage extends StatelessWidget {
  HeadingTextPage({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: Colors.black87,
      ),
    );
  }
}
