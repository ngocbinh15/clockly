import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/analys_controller.dart';
import '../../../core/constants/app_size.dart';

class PageAnalys extends StatefulWidget {
  const PageAnalys({super.key});

  @override
  State<PageAnalys> createState() => _PageAnalysState();
}

class _PageAnalysState extends State<PageAnalys> {

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalysController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Analytics",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.p16),
            child: Row(
              children: [
                const Text(
                  "This Month",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(width: AppSizes.p4),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700, size: 20),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final int total = controller.totalCount.value;
          final int completed = controller.completedCount.value;
          final int pending = controller.pendingCount.value;
          final int overdue = controller.overdueCount.value;

          final double donePercent = total > 0 ? (completed / total) * 100 : 0.0;
          final double pendingPercent = total > 0 ? (pending / total) * 100 : 0.0;
          final double overduePercent = total > 0 ? (overdue / total) * 100 : 0.0;

          final List<double> weeklyData = controller.weeklyProductivity;
          double maxWeekValue = weeklyData.reduce((a, b) => a > b ? a : b);
          if (maxWeekValue < 5) maxWeekValue = 5;

          String centerTitle = "Total";
          int centerValue = total;

          if (touchedIndex == 0) {
            centerTitle = "Completed";
            centerValue = completed;
          } else if (touchedIndex == 1) {
            centerTitle = "Pending";
            centerValue = pending;
          } else if (touchedIndex == 2) {
            centerTitle = "Late";
            centerValue = overdue;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.p32, horizontal: AppSizes.p24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.p24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Task Distribution",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: AppSizes.p32),
                      Center(
                        child: SizedBox(
                          height: 280,
                          width: 280,
                          child: total == 0
                              ?  Center(child: Text("No tasks to analyze", style: TextStyle(color: AppColors.grey)))
                              : Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event.isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection == null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                      });
                                    },
                                  ),
                                  sectionsSpace: 4,
                                  centerSpaceRadius: 85,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      color: const Color(0xFF4F80F7),
                                      value: completed.toDouble(),
                                      showTitle: completed > 0,
                                      title: '${donePercent.toStringAsFixed(0)}%',
                                      radius: touchedIndex == 0 ? 42 : 35,
                                      titleStyle: TextStyle(
                                        fontSize: touchedIndex == 0 ? 18 : 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: const Color(0xFF9075E3),
                                      value: pending.toDouble(),
                                      showTitle: pending > 0,
                                      title: '${pendingPercent.toStringAsFixed(0)}%',
                                      radius: touchedIndex == 1 ? 42 : 35,
                                      titleStyle: TextStyle(
                                        fontSize: touchedIndex == 1 ? 18 : 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: const Color(0xFFFF8FA2),
                                      value: overdue.toDouble(),
                                      showTitle: overdue > 0,
                                      title: '${overduePercent.toStringAsFixed(0)}%',
                                      radius: touchedIndex == 2 ? 42 : 35,
                                      titleStyle: TextStyle(
                                        fontSize: touchedIndex == 2 ? 18 : 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      centerTitle,
                                      style:  TextStyle(fontSize: 13, color: AppColors.grey, fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "$centerValue",
                                      style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.black, height: 1.1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.p40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegendItem("Completed (${donePercent.toStringAsFixed(0)}%)", const Color(0xFF4F80F7)),
                          _buildLegendItem("Pending (${pendingPercent.toStringAsFixed(0)}%)", const Color(0xFF9075E3)),
                        ],
                      ),
                      const SizedBox(height: AppSizes.p12),
                      Center(child: _buildLegendItem("Late (${overduePercent.toStringAsFixed(0)}%)", const Color(0xFFFF8FA2))),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.p24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.p24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Productivity Trend",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: AppSizes.p24),
                      SizedBox(
                        height: 160,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: maxWeekValue + 1,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                    if (value.toInt() >= 0 && value.toInt() < 7) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: AppSizes.p8),
                                        child: Text(
                                          days[value.toInt()],
                                          style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(7, (index) => _buildBarGroup(index, weeklyData[index], maxWeekValue + 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p16),

                Row(
                  children: [
                    Expanded(child: _buildVerticalStatCard("Completed", completed, Icons.check_rounded, const Color(0xFF4F80F7), const Color(0xFFEBF1FF))),
                    const SizedBox(width: AppSizes.p12),
                    Expanded(child: _buildVerticalStatCard("Pending", pending, Icons.access_time_rounded, const Color(0xFF9075E3), const Color(0xFFF3EFFF))),
                    const SizedBox(width: AppSizes.p12),
                    Expanded(child: _buildVerticalStatCard("Late", overdue, Icons.warning_amber_rounded, const Color(0xFFFF8FA2), const Color(0xFFFFEFEF))),
                  ],
                ),
                const SizedBox(height: AppSizes.p16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.p24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.p24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "This Month Performance",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text(
                            "${donePercent.toStringAsFixed(0)}%",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.p12),
                      Text(
                        "You completed ${donePercent.toStringAsFixed(0)}% of your tasks this month.\nKeep it up!",
                        style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: AppSizes.p16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.p12),
                        child: LinearProgressIndicator(
                          value: total > 0 ? (completed / total) : 0.0,
                          backgroundColor: Colors.grey.shade100,
                          color: AppColors.primary,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, double backgroundMax) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primary,
          width: AppSizes.p12,
          borderRadius: BorderRadius.circular(6),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: backgroundMax,
            color: Colors.grey.shade100,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildVerticalStatCard(String title, int count, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p16, horizontal: AppSizes.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.015), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: AppSizes.iconMd),
          ),
          const SizedBox(height: AppSizes.p12),
          Text(
            "$count",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: AppSizes.p4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
