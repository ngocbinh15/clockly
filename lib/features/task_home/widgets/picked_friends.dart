import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/avatar.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/team_controller.dart';

class PickedFriends extends StatelessWidget {
  PickedFriends({super.key});

  final teamLogic = Get.find<TeamController>();
  final taskLogic = Get.find<TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleAddTask(text: "Assign to"),
        const SizedBox(height: AppSizes.p12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() {
            if (teamLogic.friendList.isEmpty) {
              return Text(
                "No friends found.",
                style: GoogleFonts.inter(color: AppColors.grey),
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: teamLogic.friendList.map((user) {

                final isSelected = taskLogic.selectedMemberIds.contains(user.id);

                final shortName = user.fullName.split(' ').last;

                return GestureDetector(
                  onTap: () {
                    taskLogic.toggleMemberSelection(user.id);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: AppSizes.p16),
                    width: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Avatar(avatarURL: user.avatarUrl),
                            ),

                            if (isSelected)
                              Positioned.fill(
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary.withValues(alpha: 0.4),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 30,
                                      weight: 4,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: AppSizes.p4),

                        Text(
                          shortName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: isSelected ? AppColors.primary : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}