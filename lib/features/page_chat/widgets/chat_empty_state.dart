import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatEmptyState extends GetView<TaskHomeController> {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMagicWand01,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSizes.p24),
            Text(
              "What's on your mind?",
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.p12),
            Text(
              "Type a task naturally like 'Buy groceries tomorrow at 8 AM', and AI will organize it for you.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            SizedBox(height: 5,),
            const SizedBox(height: AppSizes.p32),
            _buildSuggestionChip("📅 Meeting next Monday at 9 AM"),
            const SizedBox(height: AppSizes.p12),
            _buildSuggestionChip("🏋️‍♂️ Hit the gym tomorrow evening"),
            const SizedBox(height: AppSizes.p12),
            _buildSuggestionChip("📖 Read 2 chapters of Flutter book"),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        controller.chatController.text = text;
        controller.isTyping.value = true;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],

        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}