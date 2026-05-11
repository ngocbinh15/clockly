import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Having trouble?",
              style: GoogleFonts.inter(
                color: const Color(0xFF334155),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            CustomTextButton(
                color: AppColors.primary,
                text: "Contact Admin",
                onTap: () {
                  // TODO: Contact Admin Page
                },
            )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Clockly v1.0.0",
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}