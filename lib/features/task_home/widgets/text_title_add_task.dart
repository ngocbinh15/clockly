import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitleAddTask extends StatelessWidget {
  TextTitleAddTask({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );
  }
}
