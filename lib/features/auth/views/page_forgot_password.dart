import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/widgets/form_forgot_password.dart';
import 'package:clockly/features/auth/widgets/heading_auth.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';

class PageForgotpassword extends GetView<LoginController> {
  const PageForgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSizes.p16),

          Column(
            children: [
              HeadingAuth(
                  icon: HugeIcons.strokeRoundedLockKey,
                  heading: "Forgot Password?",
                  title: "Enter your email address below and we'll send you a 6-digit code to reset your password."
              ),

              FormForgotPassword(),
              SizedBox(height: AppSizes.p24),
              CustomTextButton(
                  color: AppColors.primary,
                  text: "Back to LogIn",
                  onTap: () => Get.offAllNamed(AppRoutes.login),
              )
            ],
          ),
        ],
      ),
    );
  }
}