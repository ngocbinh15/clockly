import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class CustomChart extends GetView<AnalysisController> {
  const CustomChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Obx(() {
        final touchedIndex = controller.touchedIdx.value;

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
                centerSpaceRadius: 55,
                sections: showingSections(),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Column(
                key: ValueKey<int>(touchedIndex),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.chartCenterLabel,
                    style: GoogleFonts.inter(
                      color: controller.chartCenterColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    controller.chartCenterValue,
                    style: GoogleFonts.inter(
                      color: ThemeHelper.isDark ? Colors.white : Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
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
        ),
      ];
    }

    return List.generate(3, (i) {
      final isAnyTouched = controller.touchedIdx.value != -1;
      final isTouched = i == controller.touchedIdx.value;

      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 55.0 : 45.0;

      final opacity = (!isAnyTouched || isTouched) ? 1.0 : 0.4;

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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
          ),
        ),
        _ => throw StateError('Invalid'),
      };
    });
  }
}
