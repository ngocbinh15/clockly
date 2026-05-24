import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/widgets/button_logout.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
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

    return Obx(() {
      // Đăng ký phụ thuộc reactive với trạng thái theme thay đổi
      final isDark = ThemeHelper.isDark;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20, vertical: AppSizes.p16),
            children: [
              HeadingSetting(),
              const SizedBox(height: AppSizes.p24),

              const SectionTitle(title: "ACCOUNT"),
              AccountSection(),
              const SizedBox(height: AppSizes.p24),

              const SectionTitle(title: "PREFERENCES"),
              PreferencesSection(),
              const SizedBox(height: AppSizes.p24),

              const SectionTitle(title: "SUPPORT & ABOUT"),
              SupportSection(),
              const SizedBox(height: AppSizes.p24),

              ButtonLogout(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }
}