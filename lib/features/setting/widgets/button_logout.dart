import 'package:clockly/core/utils/dialog_helper.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class ButtonLogout extends GetView<SettingsController> {
  const ButtonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomDialog.confirmDialog(
          title: "Log Out?",
          content: "Are you sure you want to log out?",
          cancel: "Cancel",
          confirm: "Log Out",
          onConfirm: () => controller.authService.logout(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.p16),
        decoration: BoxDecoration(
          color: AppColors.fouth.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSizes.p16),
          border: Border.all(
            color: AppColors.fouth.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedLogout02,
              color: AppColors.fouth,
            ),
            const SizedBox(width: AppSizes.p8),
            Text(
              "Log Out",
              style: GoogleFonts.inter(
                color: AppColors.fouth,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
