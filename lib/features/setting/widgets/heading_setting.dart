import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class HeadingSetting extends StatelessWidget {
  const HeadingSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
                size: 18,
              ),
            ),
          ),
        ),

        const SizedBox(width: AppSizes.p20),

        Text(
          "Settings",
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}