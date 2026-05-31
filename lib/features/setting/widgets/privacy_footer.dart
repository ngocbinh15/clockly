import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyFooter extends GetView<SettingsController> {
  const PrivacyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Have question or need clarification?",
            style: GoogleFonts.inter(
              color: ThemeHelper.isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: AppSizes.p4),
          CustomTextButton(
            color: AppColors.primary,
            text: "binhnguyenngoc.it@gmail.com",
            onTap: () => controller.launchSupportEmail(),
          ),
          const SizedBox(height: 16),
          PrimaryButton(text: "Back to Settings", onPressed: () => Get.back()),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
