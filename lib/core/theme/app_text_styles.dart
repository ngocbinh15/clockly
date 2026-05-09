import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final heading = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static final title = GoogleFonts.inter(
    fontSize: 16 ,
    fontWeight: FontWeight.w700,
    color: Colors.black.withValues(alpha: 0.5),
  );

  static final body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static final caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}