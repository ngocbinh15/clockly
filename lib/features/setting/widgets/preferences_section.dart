import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../controller/settings_controller.dart';
import 'settings_list_tile.dart';
import 'appearance_option.dart';

class PreferencesSection extends GetView<SettingsController> {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SettingsListTile(
              icon: controller.isNotiEnabled.value
                  ? Icons.notifications_active
                  : Icons.notifications_none,
              iconColor: Colors.deepOrange,
              iconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
              title: "Notifications",
              trailing: Text(
                controller.isNotiEnabled.value ? "On" : "Off",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onTap: () => controller.handleNotificationTap(),
            ),

            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: isDark
                  ? Colors.grey.withValues(alpha: 0.15)
                  : const Color(0xFFEEEEEE),
            ),

            SettingsListTile(
              icon: Icons.palette_outlined,
              iconColor: Colors.deepPurple,
              iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
              title: "Appearance",
              trailing: Text(
                controller.selectedAppearance.value,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onTap: () {
                Get.bottomSheet(
                  Obx(() {
                    final isDarkSheet = ThemeHelper.isDark;
                    final currentAppearance =
                        controller.selectedAppearance.value;
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 24),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
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
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Appearance Mode",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkSheet
                                      ? Colors.white
                                      : Colors.black87,
                                  letterSpacing: -0.5,
                                ),
                              ),
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
                  }),
                  isScrollControlled: true,
                );
              },
            ),

            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: isDark
                  ? Colors.grey.withValues(alpha: 0.15)
                  : const Color(0xFFEEEEEE),
            ),

            SettingsListTile(
              icon: Icons.extension_outlined,
              iconColor: Colors.teal,
              iconBgColor: Colors.teal.withValues(alpha: 0.1),
              title: "Integrations",
              onTap: () =>
                  AppAlerts.warning(message: AppMessages.featureComingSoon),
            ),
          ],
        ),
      );
    });
  }
}
