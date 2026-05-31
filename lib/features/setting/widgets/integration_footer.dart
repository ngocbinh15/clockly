import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntegrationFooter extends StatelessWidget {
  const IntegrationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "More integrations coming soon!",
        style: GoogleFonts.inter(
          color: AppColors.grey.withValues(alpha: 0.6),
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
