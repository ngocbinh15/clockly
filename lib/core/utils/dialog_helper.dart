import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomDialog {
  static void showDeleteConfirm({
    required String title,
    required String content,
    required String cancle,
    required String confirm,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),

        child: Container(
          padding: const EdgeInsets.all(28),

          decoration: BoxDecoration(
            color: const Color(0xFFF7F7FA),
            borderRadius: BorderRadius.circular(32),

            boxShadow: [
              BoxShadow(
                blurRadius: 32,
                spreadRadius: -8,
                offset: const Offset(0, 16),
                color: Colors.black.withValues(alpha: 0.12),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84,
                height: 84,

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE9E9),
                ),

                child: Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedDelete02,
                    color: AppColors.fouth,
                    size: 38,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                title,
                textAlign: TextAlign.center,

                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                content,
                textAlign: TextAlign.center,

                style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Get.back(),

                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFEDEDF3),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(56),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      child: Text(
                        cancle,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        onConfirm();
                        Get.back();
                      },

                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.fouth,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(56),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      child: Text(
                        confirm,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      barrierColor: Colors.black.withValues(alpha: 0.22),
    );
  }
}