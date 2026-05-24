import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/calendar/controller/calendar_controller.dart';
import 'package:clockly/features/calendar/widget/custom_table_calendar.dart';
import 'package:clockly/features/calendar/widget/today_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class PageCalendar extends GetView<CalendarController> {
  const PageCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Đăng ký phụ thuộc reactive cho thay đổi theme
      final isDark = ThemeHelper.isDark;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchTaskDates();
            },
            color: AppColors.secondary,
            backgroundColor: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.p12,
                  left: AppSizes.p24,
                  right: AppSizes.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Calendar", style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    )),
                    const SizedBox(height: AppSizes.p24),

                    CustomTableCalendar(),
                    SizedBox(height: AppSizes.p16,),

                    Divider(color: AppColors.grey.withValues(alpha: 0.3),),

                    SizedBox(height: AppSizes.p16,),

                    TodayTask(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}