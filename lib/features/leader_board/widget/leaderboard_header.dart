import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_colors.dart';
import '../controller/team_controller.dart';
import '../../../core/components/heading_text_page.dart';
import '../../../core/utils/theme_helper.dart';
import 'friend_requests_bottom_sheet.dart';
import 'search_friend_bottom_sheet.dart';

class LeaderboardHeader extends GetView<TeamController> {
  const LeaderboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingTextPage(text: "Leaderboard"),
            const SizedBox(height: 4),
          ],
        ),
        Row(
          children: [
            Obx(() {
              final isDark = ThemeHelper.isDark;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.05),
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          const FriendRequestsBottomSheet(),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedNotification03,
                        color: isDark ? Colors.white : Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  if (controller.pendingRequests.isNotEmpty)
                    Positioned(
                      right: 0, top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                            '${controller.pendingRequests.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                ],
              );
            }),

            const SizedBox(width: 12),

            Container(
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  controller.searchResults.clear();
                  Get.bottomSheet(
                    const SearchFriendBottomSheet(),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                icon: HugeIcon(icon: HugeIcons.strokeRoundedUserAdd01, color: AppColors.primary, size: 24),
              ),
            ),
          ],
        )
      ],
    );
  }
}