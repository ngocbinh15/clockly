import 'package:clockly/features/page_chat/widgets/quick_task_dialog.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_list_tile.dart';

class SupportSection extends GetView <SettingsController> {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SettingsListTile(
            icon: Icons.help_outline,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withValues(alpha: 0.1),
            title: "Help Center",
            isExternalLink: true,
            onTap: () => controller.launchSupportEmail(),
          ),
          Divider(height: 1, indent: 16, endIndent: 16, color: ThemeHelper.isDark ? Colors.grey.withValues(alpha: 0.15) : const Color(0xFFEEEEEE)),
          SettingsListTile(
            icon: Icons.lock_outline,
            iconColor: Colors.blueGrey,
            iconBgColor: Colors.blueGrey.withValues(alpha: 0.1),
            title: "Privacy & Terms",
            onTap: () => Get.dialog(
                QuickTaskDialog()
            ),

          ),
        ],
      ),
    );
  }
}