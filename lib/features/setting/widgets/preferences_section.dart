import 'package:clockly/features/setting/controller/notification_controller.dart';
import 'package:clockly/features/setting/widgets/appearance_dialog.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import '../controller/settings_controller.dart';
import 'settings_list_tile.dart';

class PreferencesSection extends GetView<SettingsController> {
  PreferencesSection({super.key});

  final notificationController = Get.find<NotificationController>();

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
              icon: notificationController.isNotiEnabled.value
                  ? Icons.notifications_active
                  : Icons.notifications_none,
              iconColor: Colors.deepOrange,
              iconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
              title: "Notifications",
              trailing: Text(
                notificationController.isNotiEnabled.value ? "On" : "Off",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onTap: () {
                notificationController.requestPermissionNotification();
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
              icon: Icons.palette_outlined,
              iconColor: Colors.deepPurple,
              iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
              title: "Appearance",
              trailing: Text(
                controller.selectedAppearance.value,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onTap: () {
                Get.bottomSheet(AppearanceDialog(), isScrollControlled: true);
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
              onTap: () => Get.toNamed(AppRoutes.integration),
            ),
          ],
        ),
      );
    });
  }
}
