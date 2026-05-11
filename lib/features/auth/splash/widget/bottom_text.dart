import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Text ("INITIALIZING SYSTEM", style: GoogleFonts.inter(
        color: AppColors.grey,
        fontWeight: FontWeight.w600,
        fontSize: 12
    ),);
  }
}
