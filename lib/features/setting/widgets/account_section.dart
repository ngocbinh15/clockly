import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/routes/app_pages.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/settings_controller.dart';
import '../views/edit_profile_page.dart';
import 'settings_list_tile.dart';

class AccountSection extends GetView<SettingsController> {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppSizes.p16),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p8),
            onTap: () {
              Get.toNamed(AppRoutes.editProfile);
            },
            leading: Obx(() {
              final url = Get.find<AuthService>().currentUser.value?.avatarUrl;
              return CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.background,
              backgroundImage: controller.avatarUrl.value.isNotEmpty
                  ? NetworkImage(url ?? " ")
                  : null,
              child: controller.avatarUrl.value.isEmpty
                  ? Icon(Icons.person, color: AppColors.grey)
                  : null,
            );}
            ),
            title: Obx(() => Text(
              Get.find<AuthService>().currentUser.value?.fullName ?? " ",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            subtitle: Obx(() => Text(
              controller.userEmail.value,
              style: GoogleFonts.inter(color: AppColors.grey, fontSize: 14),
            )),
            trailing: Icon(Icons.chevron_right, color: AppColors.grey),
          ),
          Divider(
            height: 1,
            indent: AppSizes.p16,
            endIndent: AppSizes.p16,
            color: AppColors.grey.withValues(alpha: 0.2),
          ),
          SettingsListTile(
            icon: Icons.credit_card,
            iconColor: AppColors.primary,
            iconBgColor: AppColors.primary.withValues(alpha: 0.1),
            title: "Manage Subscription",
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "PRO",
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () => AppAlerts.warning(message: AppMessages.featureComingSoon),
          ),
        ],
      ),
    );
  }
}