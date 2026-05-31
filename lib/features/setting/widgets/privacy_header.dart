import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "We value your trust above all. This page outlines how we handle your data and the rules for using our platform.",
      style: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }
}
