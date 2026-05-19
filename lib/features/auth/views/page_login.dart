import 'dart:ui';
import 'package:clockly/core/components/app_info.dart';
import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/components/text_title.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/widgets/bottom_button.dart';
import 'package:clockly/features/auth/widgets/form_login.dart';
import 'package:clockly/features/auth/widgets/heading_auth.dart';
import 'package:clockly/features/auth/widgets/main_icon.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class PageLogin extends GetView<LoginController> {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadingAuth(
              icon: HugeIcons.strokeRoundedTime02,
              heading: "Welcome Back",
              title: "Please sign in to access your timesheet"
          ),

          FormLogin(),

          SizedBox(height: AppSizes.p24),

          Divider(
            color: AppColors.grey.withValues(alpha: 0.5),
            thickness: 1,
          ),

          SizedBox(height: AppSizes.p16),

          BottomButton(
            leftText: "Don't have an account?",
            buttonText: "Sign up",
            onTap: () => Get.toNamed(AppRoutes.signUp),
          ),

          SizedBox(height: AppSizes.p12,),

          Text(
            "Clockly v1.0.0",
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}