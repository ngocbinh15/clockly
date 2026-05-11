import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.toNamed(AppRoutes.login);
        },
        child: Text("Back to LogIn", style: GoogleFonts.inter(
          color: AppColors.primary,
          fontWeight: FontWeight.w600
        ),)
    );
  }
}
