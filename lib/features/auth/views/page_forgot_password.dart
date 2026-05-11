import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/components/text_title.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/widgets/back_to_login_button.dart';
import 'package:clockly/features/auth/widgets/form_forgot_password.dart';
import 'package:clockly/features/auth/widgets/main_icon.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
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
              MainIcon(icon: HugeIcons.strokeRoundedLockKey),
              SizedBox(height: AppSizes.p24),

              TextHeading(textHeading: "Forgot Password?"),
              SizedBox(height: AppSizes.p8),

              TextTitle(titleText: "Enter your email address below and we'll send you a 6-digit code to reset your password."),
              SizedBox(height: AppSizes.p32),

              FormForgotPassword(),
              SizedBox(height: AppSizes.p24),
              BackToLoginButton()
            ],
          ),
        ],
      ),
    );
  }
}