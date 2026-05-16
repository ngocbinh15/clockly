import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/team_controller.dart';
import 'package:clockly/features/task_home/widgets/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../widgets/search_friend_bottom_sheet.dart';

class PageTeamTask extends GetView <TeamController> {
  const PageTeamTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        final listFriend = controller.friendList;

        return SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchFriendList();
            },
            color: AppColors.secondary,
            backgroundColor: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.p12,
                  left: AppSizes.p24,
                  right: AppSizes.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Leaderboard",
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Compete with your friends!",
                              style: GoogleFonts.inter(
                                color: AppColors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.searchResults.clear();

                              Get.bottomSheet(
                                const SearchFriendBottomSheet(),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                ignoreSafeArea: false,
                              );
                            },
                            icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedUserAdd01,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: AppSizes.p24),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.grey.withValues(alpha: 0.15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search friends by email...",
                          hintStyle: GoogleFonts.inter(
                              color: AppColors.grey.withValues(alpha: 0.8),
                              fontSize: 14),
                          border: InputBorder.none,
                          icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedSearch01,
                              color: AppColors.grey,
                              size: 20
                          ),
                        ),
                        onChanged: (value) => controller.searchLocalFriends(value),
                      ),
                    ),

                    const SizedBox(height: AppSizes.p24),
                    LeaderBoard()
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}