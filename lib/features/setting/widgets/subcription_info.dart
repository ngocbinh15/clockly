import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubcriptionInfo extends GetView<OptionPlanController> {
  const SubcriptionInfo({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isChoose = controller.isChoose.value == index;

      return Padding(
        padding: const EdgeInsets.only(bottom: 14.0), 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isChoose ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
              color: isChoose ? AppColors.primary : Colors.grey.shade400,
              size: 22,
            ),
            
            const SizedBox(width: 12), 
            
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.inter(
                  color: ThemeHelper.isDark ? Colors.white70 : Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}