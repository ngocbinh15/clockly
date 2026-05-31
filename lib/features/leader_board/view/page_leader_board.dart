import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/leader_board/controller/team_controller.dart';
import 'package:clockly/features/leader_board/widget/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockly/core/utils/theme_helper.dart';

import '../../../core/constants/app_size.dart';
import '../widget/leaderboard_header.dart';
import '../widget/leaderboard_search_bar.dart';

class PageLeaderBoard extends GetView<TeamController> {
  const PageLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final _ = ThemeHelper.isDark;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
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
                    LeaderboardHeader(),

                    const SizedBox(height: AppSizes.p24),

                    const LeaderboardSearchBar(),

                    const SizedBox(height: AppSizes.p24),

                    LeaderBoard(),

                    SizedBox(height: AppSizes.p40),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
