import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class CustomMessagerBar extends GetView<TaskHomeController> {
  const CustomMessagerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      final borderColor = isDark
          ? AppColors.grey.withValues(alpha: 0.2)
          : const Color(0xFFCBD5E1);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller.chatController,
                autofocus: true,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: GoogleFonts.inter(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),

                  hintText: "What do you need to get done?",
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 48,
                    minWidth: 48,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p12,
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedMic01,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p20,
                    vertical: AppSizes.p16,
                  ),

                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 48,
                    minWidth: 48,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p16,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final text = controller.chatController.text.trim();
                        if (controller.chatController.text.isNotEmpty) {
                          Get.focusScope?.unfocus();
                          controller.chatController.clear();
                          await controller.handleChatSubmission(text);
                        }
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedSent,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
