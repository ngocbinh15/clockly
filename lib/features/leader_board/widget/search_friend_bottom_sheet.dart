import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/team_controller.dart';
import '../../../core/components/avatar.dart';

class SearchFriendBottomSheet extends GetView<TeamController> {
  const SearchFriendBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50, height: 5,
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.p24),
      
            Text("Add New Friend", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: AppSizes.p16),
      
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.grey.withValues(alpha: 0.1)),
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Enter name or email...",
                  hintStyle: GoogleFonts.inter(color: AppColors.grey, fontSize: 14),
                  border: InputBorder.none,
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01, color: AppColors.grey, size: 20),
                ),
                onChanged: (value) => controller.searchGlobalUsers(value),
              ),
            ),
            const SizedBox(height: AppSizes.p16),
      
            Obx(() {
              if (controller.isSearching.value) {
                return const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
      
              if (controller.searchResults.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      "Find someone to compete with!",
                      style: GoogleFonts.inter(color: AppColors.grey, fontSize: 14),
                    ),
                  ),
                );
              }
      
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: ListView.builder(
                  padding: EdgeInsetsGeometry.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Avatar(avatarURL: user.avatarUrl),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.fullName, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
                                Text(user.email, style: GoogleFonts.inter(color: AppColors.third, fontSize: 13)),
                              ],
                            ),
                          ),
      
                          IconButton(
                            onPressed: () => controller.sendFriendRequest(user.id),
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            ),
                            icon: HugeIcon(icon: HugeIcons.strokeRoundedUserAdd01, color: AppColors.primary, size: 20),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}