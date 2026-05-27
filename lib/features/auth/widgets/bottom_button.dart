import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.leftText,
    required this.buttonText,
    required this.onTap,
  });

  final String leftText, buttonText;
  final VoidCallback onTap;

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
            ),
          ],
        ),
      ],
    );
  }
}
