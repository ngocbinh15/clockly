import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntegrationIntro extends StatelessWidget {
  const IntegrationIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Connect Clockly with your favorite tools to automate your workflow and stay synchronized.",
      style: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 16,
        height: 1.5,
      ),
    );
  }
}
