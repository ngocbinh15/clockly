import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import 'settings_list_tile.dart';

class PreferencesSection extends StatelessWidget {
  PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SettingsListTile(
            icon: Icons.notifications_none,
            iconColor: Colors.deepOrange,
            iconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
            title: "Notifications",
            onTap: () => AppAlerts.warning(message: AppMessages.featureComingSoon),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
          SettingsListTile(
            icon: Icons.palette_outlined,
            iconColor: Colors.deepPurple,
            iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
            title: "Appearance",
            trailing: const Text("System", style: TextStyle(color: Colors.grey, fontSize: 14)),
            onTap: () => AppAlerts.warning(message: AppMessages.featureComingSoon),
          ),
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