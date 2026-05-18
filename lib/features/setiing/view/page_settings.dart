import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/settings_controller.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({super.key});

  @override
  State<PageSettings> createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  final SettingsController controller = Get.find<SettingsController>();

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      Get.snackbar("Lỗi", "Không thể mở đường dẫn này");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("ACCOUNT"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: GestureDetector(
                      onTap: () => controller.updateAvatar(),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(() => CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey.withValues(alpha: 0.2),
                            backgroundImage: controller.avatarUrl.value.isNotEmpty
                                ? NetworkImage(controller.avatarUrl.value)
                                : null,
                            child: controller.avatarUrl.value.isEmpty
                                ? const Icon(Icons.person, color: Colors.grey)
                                : null,
                          )),
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Obx(() => Text(
                      controller.userName.value,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                    subtitle: Obx(() => Text(
                      controller.userEmail.value,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    )),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
                  _buildListTile(
                    icon: Icons.credit_card,
                    iconColor: Colors.indigo,
                    iconBgColor: Colors.indigo.withValues(alpha: 0.1),
                    title: "Manage Subscription",
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "PRO",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    onTap: () => Get.snackbar("Manage Subscription", "Tính năng đang phát triển"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("PREFERENCES"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.notifications_none,
                    iconColor: Colors.deepOrange,
                    iconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
                    title: "Notifications",
                    onTap: () => Get.snackbar("Notifications", "Mở cài đặt thông báo"),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
                  _buildListTile(
                    icon: Icons.palette_outlined,
                    iconColor: Colors.deepPurple,
                    iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
                    title: "Appearance",
                    trailing: const Text("System", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    onTap: () => Get.snackbar("Appearance", "Đổi giao diện sáng/tối"),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
                  _buildListTile(
                    icon: Icons.extension_outlined,
                    iconColor: Colors.teal,
                    iconBgColor: Colors.teal.withValues(alpha: 0.1),
                    title: "Integrations",
                    onTap: () => Get.snackbar("Integrations", "Mở cài đặt liên kết"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("SUPPORT & ABOUT"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.help_outline,
                    iconColor: Colors.blue,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    title: "Help Center",
                    isExternalLink: true,
                    // Thay bằng link thực tế của bạn
                    onTap: () => _launchURL("https://google.com"),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
                  _buildListTile(
                    icon: Icons.lock_outline,
                    iconColor: Colors.blueGrey,
                    iconBgColor: Colors.blueGrey.withValues(alpha: 0.1),
                    title: "Privacy & Terms",
                    onTap: () => _launchURL("https://google.com"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            GestureDetector(
              onTap: () => controller.logOut(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    Widget? trailing,
    bool isExternalLink = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) ...[
            trailing,
            const SizedBox(width: 8),
          ],
          Icon(
            isExternalLink ? Icons.open_in_new : Icons.chevron_right,
            color: Colors.grey[400],
            size: 20,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}