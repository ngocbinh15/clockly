import 'package:clockly/core/components/heading_text_page.dart';
import 'package:clockly/features/analys/controller/analys_controller.dart';
import 'package:clockly/features/analys/widget/custom_pie_chart.dart';
import 'package:clockly/features/analys/widget/list_infomation.dart';
// 👉 1. IMPORT LẠI 2 WIDGET BỊ THIẾU
import 'package:clockly/features/analys/widget/productivity_trend_card.dart';
import 'package:clockly/features/analys/widget/weekly_performance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class PageAnalys extends GetView<AnalysController> {
  const PageAnalys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            controller.calcPercent();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingTextPage(text: "Analytics"),
                      Obx(() {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.timeFilter.value,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              style: GoogleFonts.inter(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              dropdownColor: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                              items: <String>['Today', 'This Week', 'This Month']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.timeFilter.value = newValue;
                                  controller.calcPercent();
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p24),

                  CustomPieChart(),


                  const SizedBox(height: AppSizes.p16),

                  const ProductivityTrendCard(),

                  const SizedBox(height: AppSizes.p16),

                  ListInfomation(),

                  const SizedBox(height: AppSizes.p16),

                  const WeeklyPerformanceCard(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}