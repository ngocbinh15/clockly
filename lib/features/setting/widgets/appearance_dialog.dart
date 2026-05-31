import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:clockly/features/setting/widgets/appearance_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppearanceDialog extends GetView<SettingsController> {
  const AppearanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkSheet = ThemeHelper.isDark;
      final currentAppearance = controller.selectedAppearance.value;
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 32),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: isDarkSheet
                    ? Colors.grey.shade700
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 10,
                left: 24,
                right: 24,
              ),
              child: Row(
                children: [
                  Text(
                    "Appearance",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDarkSheet ? Colors.white : Colors.black,
                    ),
                  ),
                  const Spacer(),
                  // Quick close button
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: isDarkSheet ? Colors.grey : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AppearanceOption(
              title: "Light Mode",
              icon: Icons.wb_sunny_outlined,
              isSelected: currentAppearance == "Light",
              onTap: () {
                controller.changeAppearance("Light");
                Get.back();
              },
              isDark: isDarkSheet,
            ),
            AppearanceOption(
              title: "Dark Mode",
              icon: Icons.dark_mode_outlined,
              isSelected: currentAppearance == "Dark",
              onTap: () {
                controller.changeAppearance("Dark");
                Get.back();
              },
              isDark: isDarkSheet,
            ),
            AppearanceOption(
              title: "System default",
              icon: Icons.settings_suggest_outlined,
              isSelected: currentAppearance == "System",
              onTap: () {
                controller.changeAppearance("System");
                Get.back();
              },
              isDark: isDarkSheet,
            ),
          ],
        ),
      );
    });
  }
}
