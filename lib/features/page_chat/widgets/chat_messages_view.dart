import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessagesView extends GetView<TaskHomeController> {
  const ChatMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BubbleSpecialOne(
          text: controller.nameController.text,
          tail: true,
          color: AppColors.primary.withValues(alpha: 0.5),
          isSender: true,
        ),
        const SizedBox(height: AppSizes.p16),
        Obx(() {
          if (controller.isGenerating.value) {
            return TypingIndicatorWave(
              showIndicator: true,
              bubbleColor: AppColors.secondary,
              dotColor: Colors.grey.shade400,
            );
          }
          return BubbleSpecialOne(
            color: AppColors.contentDone,
            textStyle: GoogleFonts.inter(
              color: AppColors.secondary,
              fontSize: 16,
            ),
            text: "Task added successfully! Here are the details ✨",
            tail: true,
            isSender: false,
          );
        }),
      ],
    );
  }
}