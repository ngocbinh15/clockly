import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart'; // Chú ý sửa tên import nếu cần
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyPerformanceCard extends GetView<AnalysisController> {
  const WeeklyPerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final percent = controller.weeklyPercent.value;
      final filterText = controller.timeFilter.value;

      String timeStr = filterText == 'Today' ? 'today' : (filterText == 'This Week' ? 'this week' : 'this month');

      String message = "You completed $percent% of your tasks $timeStr. Keep it up!";
      if (percent == 100) {
        message = "Perfect! You completed all your tasks $timeStr. 🎉";
      } else if (percent < 50 && percent > 0) {
        message = "You completed $percent% of your tasks. Let's push a bit harder! 💪";
      } else if (percent == 0) {
        message = "You haven't completed any tasks $timeStr yet. Let's get started!";
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.p20),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(AppSizes.p16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$filterText Performance",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "$percent%",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p12),
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSizes.p20),

            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percent / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}