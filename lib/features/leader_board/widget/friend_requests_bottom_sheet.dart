import 'package:clockly/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/team_controller.dart';
import '../../../core/components/avatar.dart';

class FriendRequestsBottomSheet extends GetView<TeamController> {
  const FriendRequestsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              decoration: BoxDecoration(color: AppColors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: AppSizes.p24),

          Text("Friend Requests", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSizes.p16),

          Obx(() {
            if (controller.pendingRequests.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Text("No pending requests.", style: GoogleFonts.inter(color: AppColors.grey, fontSize: 15)),
                ),
              );
            }

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.pendingRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.pendingRequests[index];
                  final String friendshipId = request['id'];
                  final user = UserModel.fromMap(request['requester']);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.grey.withValues(alpha: 0.1)),
                    ),
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
                          onPressed: () => controller.declineRequest(friendshipId),
                          style: IconButton.styleFrom(backgroundColor: Colors.red.withValues(alpha: 0.1)),
                          icon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01, color: Colors.red, size: 20),
                        ),
                        const SizedBox(width: 8),

                        IconButton(
                          onPressed: () => controller.acceptRequest(friendshipId),
                          style: IconButton.styleFrom(backgroundColor: Colors.green.withValues(alpha: 0.1)),
                          icon: const HugeIcon(icon: HugeIcons.strokeRoundedTick01, color: Colors.green, size: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}