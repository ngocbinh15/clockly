import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class HeadingChat extends StatelessWidget {
  const HeadingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Clockly Chat",
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: -0.5,
            ),
          ),

          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
                Get.find<TaskHomeController>().resetChatState();
                },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black87,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
