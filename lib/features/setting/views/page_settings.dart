import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/settings_controller.dart';
import '../widgets/account_section.dart';
import '../widgets/preferences_section.dart';
import '../widgets/section_title.dart';
import '../widgets/support_section.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20, vertical: AppSizes.p16),
          children: [
            Text(
              "Settings",
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.p24),

            const SectionTitle(title: "ACCOUNT"),
            const AccountSection(),
            const SizedBox(height: AppSizes.p24),

            const SectionTitle(title: "PREFERENCES"),
            PreferencesSection(),
            const SizedBox(height: AppSizes.p24),

            const SectionTitle(title: "SUPPORT & ABOUT"),
            const SupportSection(),
            const SizedBox(height: AppSizes.p24),

            _buildLogoutButton(controller),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(SettingsController controller) {
    return GestureDetector(
      onTap: () => controller.authService.logout(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.p16),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(AppSizes.p16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, color: AppColors.fouth, size: 20),
            const SizedBox(width: AppSizes.p8),
            Text(
              "Log Out",
              style: GoogleFonts.inter(
                color: AppColors.fouth,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}