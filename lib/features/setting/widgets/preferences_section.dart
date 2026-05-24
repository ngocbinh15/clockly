import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../controller/settings_controller.dart';
import 'settings_list_tile.dart';

class PreferencesSection extends GetView<SettingsController> {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Obx(() => SettingsListTile(
            icon: controller.isNotiEnabled.value ? Icons.notifications_active : Icons.notifications_none,
            iconColor: Colors.deepOrange,
            iconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
            title: "Notifications",
            trailing: Text(controller.isNotiEnabled.value ? "On" : "Off", style: const TextStyle(color: Colors.grey, fontSize: 14)),
            onTap: () => controller.handleNotificationTap(),
          )),

          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),

          Obx(() => SettingsListTile(
            icon: Icons.palette_outlined,
            iconColor: Colors.deepPurple,
            iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
            title: "Appearance",
            trailing: Text(controller.selectedAppearance.value, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            onTap: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(title: const Text("Light"), onTap: () { controller.changeAppearance("Light"); Get.back(); }),
                      ListTile(title: const Text("Dark"), onTap: () { controller.changeAppearance("Dark"); Get.back(); }),
                      ListTile(title: const Text("System"), onTap: () { controller.changeAppearance("System"); Get.back(); }),
                    ],
                  ),
                ),
              );
            },
          )),

          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),

          SettingsListTile(
            icon: Icons.extension_outlined,
            iconColor: Colors.teal,
            iconBgColor: Colors.teal.withValues(alpha: 0.1),
            title: "Integrations",
            onTap: () => AppAlerts.warning(message: AppMessages.featureComingSoon),
          ),
        ],
      ),
    );
  }
}