import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class TextFiledAddTask extends StatelessWidget {
  TextFiledAddTask({super.key});

  final controller = Get.find<TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autofocus: true,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onChanged: (value) {
              controller.isTyping.value = value.trim().isNotEmpty;
              controller.isGenerated.value = false;
            },
            controller: controller.nameController,
            decoration: InputDecoration(
              hintText: "What do you need to get done?",
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,

              suffixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),

              suffixIcon: Obx(() {
                if (controller.isGenerating.value) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  );
                } else if (controller.isGenerated.value) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedTickDouble02,
                      size: 24,
                      color: Colors.green,
                    ),
                  );
                } else if (controller.isTyping.value) {
                  return GestureDetector(
                    onTap: () async {
                      await controller.generateTask();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedMagicWand01,
                        size: 24,
                        color: Colors.blueAccent,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedPencilEdit01,
                      size: 24,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  );
                }
              }),
            ),
            validator: (value) => Validate.validName(value),
          ),

          TextFormField(
            maxLines: 3,
            minLines: 1,
            controller: controller.decriptionController,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            decoration: InputDecoration(
              hintText: "Add description",
              hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 8, bottom: 16),
            ),
          ),

          SizedBox(height: AppSizes.p12),
        ],
      );
    });
  }
}
