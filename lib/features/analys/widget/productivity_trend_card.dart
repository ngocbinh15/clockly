import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class ProductivityTrendCard extends GetView<AnalysisController> {
  const ProductivityTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(AppSizes.p16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Productivity Trend",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.p32),

            AspectRatio(
              aspectRatio: 1.8,
              child: Obx(() {
                final trendData = controller.weeklyTrend;
                double maxY = trendData
                    .reduce((curr, next) => curr > next ? curr : next)
                    .toDouble();
                if (maxY < 5) maxY = 5;

                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,

                    barTouchData: BarTouchData(
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            barTouchResponse == null ||
                            barTouchResponse.spot == null) {
                          controller.touchedBarIdx.value = -1;
                          return;
                        }
                        controller.touchedBarIdx.value =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                      },
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.black87,
                        tooltipBorderRadius: BorderRadius.circular(8),
                        tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.toInt()} Tasks',
                            GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),

                    barGroups: List.generate(7, (index) {
                      final isTouched = index == controller.touchedBarIdx.value;
                      final isAnyTouched = controller.touchedBarIdx.value != -1;

                      final double opacity = (!isAnyTouched || isTouched)
                          ? 1.0
                          : 0.3;

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: trendData[index].toDouble(),
                            width: isTouched ? 18 : 14,
                            borderRadius: BorderRadius.circular(6),

                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: opacity),
                                AppColors.primary.withValues(alpha: opacity),
                                // const Color(0xFF42A5F5).withValues(alpha: opacity),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),

                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxY,
                              color: AppColors.grey.withValues(alpha: 0.08),
                            ),
                          ),
                        ],
                      );
                    }),

                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),

                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun',
                            ];

                            final isTouched =
                                value.toInt() == controller.touchedBarIdx.value;
                            final isAnyTouched =
                                controller.touchedBarIdx.value != -1;
                            final double textOpacity =
                                (!isAnyTouched || isTouched) ? 1.0 : 0.4;

                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                days[value.toInt()],
                                style: GoogleFonts.inter(
                                  color: AppColors.grey.withValues(
                                    alpha: textOpacity,
                                  ),
                                  fontSize: 12,
                                  fontWeight: isTouched
                                      ? FontWeight.w700
                                      : FontWeight.w500, // Bold when touched
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
