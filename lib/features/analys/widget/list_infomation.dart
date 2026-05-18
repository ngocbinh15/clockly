import 'package:clockly/features/analys/controller/analysis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import 'information_card.dart';

class ListInfomation extends GetView <AnalysisController> {
  const ListInfomation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: CustomInformationCard(
                icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                taskCount: controller.doneCount.value,
                label: "Completed",
                color: AppColors.contentDone
            ),
          ),

          SizedBox(width: AppSizes.p16,),

          Expanded(
            child: CustomInformationCard(
                icon: HugeIcons.strokeRoundedClock01,
                taskCount: controller.pendingCount.value,
                label: "Pending",
                color: AppColors.contentPending
            ),
          ),

          SizedBox(width: AppSizes.p16,),

          Expanded(
            child: CustomInformationCard(
                icon: HugeIcons.strokeRoundedAlert01,
                taskCount: controller.lateCount.value,
                label: "Late",
                color: AppColors.contentLate
            ),
          ),
        ],
      );
    });
  }
}
