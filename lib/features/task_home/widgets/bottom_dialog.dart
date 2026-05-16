import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/dialog_helper.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/pick_date_add_task.dart';
import 'package:clockly/features/task_home/widgets/picked_friends.dart';
import 'package:clockly/features/task_home/widgets/priority_selector.dart';
import 'package:clockly/features/task_home/widgets/text_filed_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import 'custom_actiom_chip.dart';

class BottomDialog {
  static void showAddTaskBottomSheet() {
    final controller = Get.find <TaskHomeController>();

    Get.bottomSheet(
      GestureDetector(
        onTap: () {
          Get.focusScope?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p24, vertical: AppSizes.p8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 70,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
          
                SizedBox(height: AppSizes.p16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add New Task", style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                    )),
                    GestureDetector(
                      onTap: () {
                        if (controller.nameController.text.isNotEmpty || controller.decriptionController.text.isNotEmpty || controller.dateController.text.isNotEmpty) {
                          CustomDialog.showDeleteConfirm(
                            title: "Discard draft?",
                            content: "Your changes haven’t been saved yet. Are you sure you want to discard them?",
                            cancle: "Keep editing",
                            confirm: "Discard",
                            onConfirm: () {
                              Get.back();
                              controller.dateController.clear();
                              controller.nameController.clear();
                              controller.decriptionController.clear();
                            },
                          );
                        }
                        else {
                          Get.back();
                        }
                      },
                      child: Container(
                        padding: EdgeInsetsGeometry.all(AppSizes.p4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey.withValues(alpha: 0.2)
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedCancel01,
                          size: 20,
                          color: Colors.black.withValues(alpha: 0.6),
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  ],
                ),

                Form (
                  key: controller.formStateAddTask,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.p16,),

                      TextFiledAddTask(),

                      CustomActiomChip(),

                      SizedBox(height: AppSizes.p16,),

                      Obx(() {
                        return PrioritySelector(
                          selectedPriority: controller.selectedPriority.value,
                          onChanged: (p0) => controller.selectedPriority.value = p0,
                        );
                      }),

                      SizedBox(height: AppSizes.p16,),
                      PickDateAddTask(),

                      SizedBox(height: AppSizes.p16,),
                      PickedFriends(),

                      SizedBox(height: AppSizes.p24,),
                      PrimaryButton(
                          text: "Save Task",
                          onPressed: () async {
                            if (controller.formStateAddTask.currentState!.validate()) {
                              await controller.saveTask();
                            }
                          },
                        suffixIcon: HugeIcons.strokeRoundedArrowUp01,
                      )
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.p12,)
              ],
            ),
          ),
        ),
      ),

      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      ignoreSafeArea: false,
    );
  }
}