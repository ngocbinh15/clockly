import 'package:clockly/core/components/heading_text_page.dart';
import 'package:clockly/features/analys/controller/analys_controller.dart';
import 'package:clockly/features/analys/widget/custom_pie_chart.dart';
import 'package:clockly/features/analys/widget/information_card.dart';
import 'package:clockly/features/analys/widget/list_infomation.dart';
import 'package:clockly/features/analys/widget/note_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../widget/weekly_performance_card.dart';


class PageAnalys extends GetView <AnalysController> {
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
                  HeadingTextPage(text: "Analytics"),
                  SizedBox(height: AppSizes.p24),

                  CustomPieChart(),

                  SizedBox(height: AppSizes.p16,),

                  ListInfomation(),

                  SizedBox(height: AppSizes.p16),

                  WeeklyPerformanceCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
