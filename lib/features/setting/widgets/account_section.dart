import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/settings_controller.dart';
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
            Obx(() {
            bool isPro = Get.find<OptionPlanController>().isPro.value; 

            return SettingsListTile(
                icon: Icons.credit_card,
                iconColor: AppColors.primary,
                iconBgColor: AppColors.primary.withValues(alpha: 0.1),
                // Đổi tiêu đề: Nếu chưa Pro thì giục Upgrade, nếu Pro rồi thì cho Manage
                title: isPro ? "Manage Subscription" : "Upgrade to Pro", 
                trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p8, vertical: 4),
                decoration: BoxDecoration(
                    // Màu nền thẻ: Pro thì nền Xanh, Free thì nền Cam/Vàng báo hiệu
                    color: isPro 
                        ? AppColors.primary.withValues(alpha: 0.1) 
                        : AppColors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                    isPro ? "PRO" : "FREE", // Đổi chữ trong badge
                    style: GoogleFonts.inter(
                    // Màu chữ: Pro thì chữ Xanh, Free thì chữ Cam
                    color: isPro ? AppColors.primary : AppColors.orange.withValues(alpha: 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    ),
                ),
                ),
                onTap: () => Get.toNamed(AppRoutes.subcription),
            );
            })
        ],
      ),
    );
  }
}