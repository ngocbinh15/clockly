import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ChipItem extends StatelessWidget {
  const ChipItem({
    super.key,
    required this.controller,
    required this.categoryName,
    required this.icon,
    required this.isSelected,
    required this.isDark,
  });

  final TaskHomeController controller;
  final String categoryName;
  final dynamic icon;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected
        ? AppColors.primary.withValues(alpha: 0.12)
        : (isDark
              ? Colors.white.withValues(alpha: 0.05)
              : AppColors.background);

    final Color borderColor = isSelected
        ? AppColors.primary
        : AppColors.grey.withValues(alpha: 0.3);

    final Color contentColor = isSelected ? AppColors.primary : AppColors.grey;

    return GestureDetector(
      onTap: () => controller.selectedAddTask.value = categoryName,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p20,
          vertical: AppSizes.p8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(icon: icon, color: contentColor, size: 18),
            const SizedBox(width: 8),
            Text(
              categoryName,
              style: GoogleFonts.inter(
                color: contentColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
