import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/theme_helper.dart';
import '../controller/team_controller.dart';

class LeaderboardSearchBar extends GetView<TeamController> {
  const LeaderboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey.withValues(alpha: 0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
        ),
        child: TextField(
          style: GoogleFonts.inter(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Search friends by name or email...",
            hintStyle: GoogleFonts.inter(color: AppColors.grey.withValues(alpha: 0.8), fontSize: 14),
            border: InputBorder.none,
            icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: AppColors.grey,
                size: 20
            ),
          ),
          onChanged: (value) => controller.searchLocalFriends(value),
        ),
      );
    });
  }
}