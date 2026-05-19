import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/utils/dialog_helper.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/list_avatar.dart';
import 'package:clockly/features/task_home/widgets/task_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hugeicons/hugeicons.dart';

import '../model/task.dart';
import '../model/task_category.dart';

class TaskList extends GetView<TaskHomeController> {
  const TaskList({super.key, required this.label, required this.tasks, this.labelColor});

  final String label;
  final List<TaskModel> tasks;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              color: labelColor ?? AppColors.third,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSizes.p12),

          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final isCompleted = task.status == 'completed';

              final List<String> listAvatars = controller.taskMembersMap[task.id] ?? [];
              final bool isTeamTask = listAvatars.isNotEmpty;

              return Padding(
                padding: EdgeInsets.only(bottom: AppSizes.p12),
                child: Slidable(
                    key: ValueKey(task.id),
                    startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          CustomSlidableAction(
                            onPressed: (context) {
                              CustomDialog.confirmDialog(
                                title: "Delete task?",
                                content: "This will permanently delete this task. You can’t undo this action.",
                                cancel: "Cancel",
                                confirm: "Delete",
                                onConfirm: () => controller.deleteTask(task),
                              );
                            },
                            backgroundColor: AppColors.fouth,
                            borderRadius: BorderRadius.circular(16),
                            child: const SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedDelete02,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  SizedBox(height: 4),
                                  Text('Delete', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          )
                        ]
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.p16),
                      decoration: BoxDecoration(
                        color: isCompleted ? AppColors.background : AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              side: BorderSide(color: AppColors.grey, width: 1.2),
                              value: isCompleted,
                              shape: const CircleBorder(),
                              activeColor: AppColors.primary,
                              onChanged: (bool? newValue) {
                                controller.toggleTaskStatus(task);
                              },
                            ),
                          ),
                          const SizedBox(width: AppSizes.p8),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: GoogleFonts.inter(
                                    color: isCompleted ? AppColors.grey : Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    letterSpacing: 0,
                                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isCompleted ? AppColors.grey.withValues(alpha: 0.1) : task.category.color.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        task.category.displayName.toUpperCase(),
                                        style: GoogleFonts.inter(
                                          color: isCompleted ? AppColors.grey : task.category.color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: AppSizes.p12,),

                                    Text(
                                      controller.formatTime(task.dueDate),
                                      style: GoogleFonts.inter(
                                        color: AppColors.third,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),


                                if (isTeamTask) ...[
                                  SizedBox(height: AppSizes.p8),
                                  ListAvatar(avatarUrls: listAvatars,),
                                ],
                              ],
                            ),
                          ),

                          if (!isCompleted)
                            IconButton(
                              icon: const Icon(Icons.more_vert, color: Colors.grey),
                              onPressed: () {
                                Get.bottomSheet(
                                  TaskDetailsBottomSheet(
                                    task: task,
                                    isTeamTask: isTeamTask,
                                    listAvatars: listAvatars,
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            )
                        ],
                      ),
                    )
                ),
              );
            },
          )
        ],
      ),
    );
  }
}