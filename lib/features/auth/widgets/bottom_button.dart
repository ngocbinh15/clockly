import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/routes/app_pages.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomButton extends StatelessWidget {
  BottomButton({super.key, required this.leftText, required this.buttonText, required this.onTap});

  String leftText, buttonText;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              leftText,
              style: GoogleFonts.inter(
                color: const Color(0xFF334155),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: AppSizes.p8),
            CustomTextButton(
                color: AppColors.primary,
                text: buttonText,
                onTap: onTap,
            )
          ],
        ),
      ],
    );
  }
}