import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChart extends GetView<AnalysisController> {
  const CustomChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Obx(() {
        return Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      controller.touchedIdx.value = -1;
                      return;
                    }
                    controller.touchedIdx.value =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 3,
                centerSpaceRadius: 50,
                sections: showingSections(),
              ),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total",
                  style: GoogleFonts.inter(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${controller.filteredTotalCount.value}",
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (controller.latePercent.value == 0 &&
        controller.pendingPercent.value == 0 &&
        controller.donePercent.value == 0) {
      return [
        PieChartSectionData(
          color: AppColors.background,
          value: 100,
          title: '',
          radius: 50,
        )
      ];
    }

    return List.generate(3, (i) {
      final isAnyTouched = controller.touchedIdx.value != -1;
      final isTouched = i == controller.touchedIdx.value;

      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;

      final opacity = (!isAnyTouched || isTouched) ? 1.0 : 0.5;

      return switch (i) {
        0 => PieChartSectionData(
          color: AppColors.contentLate.withValues(alpha: opacity),
          value: controller.latePercent.value.toDouble(),
          title: '${controller.latePercent.value}%',
          radius: radius,
          showTitle: controller.latePercent.value > 0,
          titleStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
          ),
        ),
        1 => PieChartSectionData(
          color: AppColors.contentPending.withValues(alpha: opacity),
          value: controller.pendingPercent.value.toDouble(),
          title: '${controller.pendingPercent.value}%',
          radius: radius,
          showTitle: controller.pendingPercent.value > 0,
          titleStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.secondary,
          ),
        ),
        2 => PieChartSectionData(
          color: AppColors.contentDone.withValues(alpha: opacity),
          value: controller.donePercent.value.toDouble(),
          title: '${controller.donePercent.value}%',
          radius: radius,
          showTitle: controller.donePercent.value > 0,
          titleStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.secondary,
          ),
        ),
        _ => throw StateError('Invalid'),
      };
    });
  }
}