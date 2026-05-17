import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:clockly/features/leader_board/controller/team_controller.dart';
import 'package:clockly/core/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/utils/dialog_helper.dart';

class LeaderBoard extends GetView<TeamController> {
  LeaderBoard({super.key});

  final Map<int, dynamic> colorPosition = {
    1: const Color(0xFFF59E0B),
    2: const Color(0xFF9CA3AF),
    3: const Color(0xFFD97706)
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.leaderBoard.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      UserModel currUser = controller.authService.currentUser.value!;
      int currPosition = controller.leaderBoard.indexWhere((element) =>
      element.id == currUser.id) + 1;

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.p16, horizontal: AppSizes.p20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(AppSizes.p16)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Avatar(avatarURL: currUser.avatarUrl),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.secondary
                                ),
                                child: Text(
                                  "#$currPosition", style: GoogleFonts.inter(
                                    color: AppColors.third,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12
                                ),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: AppSizes.p16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You", style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),),
                        Text("${currUser.totalPoints} Task Points",
                          style: GoogleFonts.inter(
                              color: AppColors.third,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),)
                      ],
                    ),
                  ],
                ),

                if (currPosition <= 3)
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: colorPosition[currPosition].withValues(alpha: 0.15),
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedStarAward01,
                        color: colorPosition[currPosition],
                      ),
                    ),
                  )
              ],
            ),
          ),

          const SizedBox(height: AppSizes.p24),

          ListView.builder(
              itemCount: controller.filteredLeaderBoard.length,
              shrinkWrap: true,
              padding: EdgeInsetsGeometry.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                UserModel currUserModel = controller.filteredLeaderBoard[index];

                int rank = index + 1;
                bool isMe = currUserModel.id == currUser.id;

                return GestureDetector(
                  onLongPress: () {
                    if (!isMe) {
                      CustomDialog.showDeleteConfirm(
                        title: "Unfriend ${currUserModel.fullName}?",
                        content: "Are you sure you want to remove this person from your friend list? They will be removed from your leaderboard.",
                        cancle: "Cancel",
                        confirm: "Unfriend",
                        onConfirm: () {
                          Get.back();
                          controller.unfriend(currUserModel.id);
                        },
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppSizes.p12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(AppSizes.p16),
                      border: isMe
                          ? Border.all(color: AppColors.primary, width: 1.5)
                          : Border.all(color: AppColors.grey.withValues(alpha: 0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            "$rank",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isMe ? AppColors.primary : AppColors.third,
                            ),
                          ),
                        ),

                        Avatar(avatarURL: currUserModel.avatarUrl),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isMe ? "You" : currUserModel.fullName,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${currUserModel.totalPoints} Tasks Points",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (rank <= 3)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: colorPosition[rank].withValues(alpha: 0.15),
                                shape: BoxShape.circle
                            ),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedStarAward01,
                              color: colorPosition[rank],
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
          )
        ],
      );
    });
  }
}