import 'package:clockly/core/components/heading_text_page.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:clockly/features/analys/widget/custom_button_dropdown.dart';
import 'package:clockly/features/analys/widget/custom_pie_chart.dart';
import 'package:clockly/features/analys/widget/list_infomation.dart';
import 'package:clockly/features/analys/widget/productivity_trend_card.dart';
import 'package:clockly/features/analys/widget/weekly_performance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class PageAnalys extends GetView<AnalysisController> {
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

                      CustomButtonDropdown(),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p24),

                  CustomPieChart(),

                  const SizedBox(height: AppSizes.p16),

                  ProductivityTrendCard(),

                  const SizedBox(height: AppSizes.p16),

                  ListInfomation(),

                  const SizedBox(height: AppSizes.p16),

                  const WeeklyPerformanceCard(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
