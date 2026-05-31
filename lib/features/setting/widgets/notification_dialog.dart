import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDialog extends GetView<NotificationController> {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkSheet = ThemeHelper.isDark;

      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 32),
        decoration: BoxDecoration(
          color: isDarkSheet ? const Color(0xFF1A1C1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDarkSheet
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Row(
                children: [
                  Text(
                    "Notifications",
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

            _buildNotificationItem(
              title: "Daily Summary",
              subtitle: "Get a briefing of your day at 8:00 AM",
              icon: Icons.wb_twilight_rounded,
              iconColor: Colors.orange,
              value: controller.isDailyReminderOn.value,
              onChanged: (val) => controller.toggleDailyReminder(val),
              isDark: isDarkSheet,
            ),

            const SizedBox(height: 12),

            _buildNotificationItem(
              title: "Task Reminders",
              subtitle: "Alerts 15 minutes before task starts",
              icon: Icons.alarm_on_rounded,
              iconColor: AppColors.primary,
              value: controller.isTaskReminderOn.value,
              onChanged: (val) => controller.toggleTaskReminder(val),
              isDark: isDarkSheet,
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Keep these on to stay productive and never miss a deadline.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool value,
    required Function(bool) onChanged,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          // Text details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          
          Switch.adaptive(
            value: value,
            // ignore: deprecated_member_use
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
