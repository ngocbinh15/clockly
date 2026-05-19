import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_list_tile.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      Get.snackbar("Lỗi", "Không thể mở đường dẫn này");
    }
  }

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
            icon: Icons.help_outline,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withValues(alpha: 0.1),
            title: "Help Center",
            isExternalLink: true,
            onTap: () => _launchURL("https://google.com"),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
          SettingsListTile(
            icon: Icons.lock_outline,
            iconColor: Colors.blueGrey,
            iconBgColor: Colors.blueGrey.withValues(alpha: 0.1),
            title: "Privacy & Terms",
            onTap: () => _launchURL("https://google.com"),
          ),
        ],
      ),
    );
  }
}