import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:clockly/features/analys/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteChart extends GetView<AnalysisController> {
  const NoteChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final touchedIdx = controller.touchedIdx.value;
      final isAnyTouched = touchedIdx != -1;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Indicator(
                color: AppColors.contentDone,
                text: "Completed (${controller.donePercent.value}%)",
                isSquare: false,
                textColor: AppColors.grey,
                isDimmed: isAnyTouched && touchedIdx != 2,
              ),

              const SizedBox(width: 30),

              Indicator(
                color: AppColors.contentPending,
                text: "Pending (${controller.pendingPercent.value}%)",
                isSquare: false,
                textColor: AppColors.grey,
                isDimmed: isAnyTouched && touchedIdx != 1,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Indicator(
            color: AppColors.contentLate,
            text: "Late (${controller.latePercent.value}%)",
            isSquare: false,
            textColor: AppColors.grey,
            isDimmed: isAnyTouched && touchedIdx != 0,
          ),
        ],
      );
    });
  }
}
