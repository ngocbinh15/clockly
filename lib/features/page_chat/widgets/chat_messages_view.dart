import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatMessagesView extends GetView<TaskHomeController> {
  const ChatMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.chatMessages.length + (controller.isGenerating.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.chatMessages.length) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
                child: TypingIndicatorWave(
                  showIndicator: true,
                  bubbleColor: Colors.white,
                  dotColor: Colors.grey.shade400,
                ),
              ),
            );
          }

          final msg = controller.chatMessages[index];

          if (msg.isTaskCard && msg.taskData != null) {
            return _buildTaskCard(msg.taskData!);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BubbleSpecialOne(
              text: msg.text,
              isSender: msg.isSender,
              color: msg.isSender
                  ? AppColors.primary.withValues(alpha: 0.9)
                  : Colors.white,
              textStyle: GoogleFonts.inter(
                color: msg.isSender ? Colors.white : Colors.black87,
                fontSize: 15,
                height: 1.4,
              ),
              tail: false,
            ),
          );
        },
      );
    });
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final title = task['title'] ?? 'New Task';
    final description = task['description'];
    final dueDate = task['due_date'] ?? 'No date set';
    final category = task['category'] ?? 'GENERAL';

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 48, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),

          if (description != null && description != " " && description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

          const SizedBox(height: 16),

          Row(
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar01,
                size: 16,
                color: Colors.black54,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  dueDate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}