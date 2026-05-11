// Trong file auth_helper.dart
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthHelper {
  static bool _isLoadingOpen = false;

  static void showLoading() {
    if (_isLoadingOpen) return;
    _isLoadingOpen = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Container(
          color: Colors.black.withValues(alpha: 0.4),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  static void hideLoading() {
    if (_isLoadingOpen) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      _isLoadingOpen = false;
    }
  }

  static void dialogOTP(OtpType type) {
    final controller = Get.find<LoginController>();

    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 28,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Enter the 6-digit code sent to your email",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 24),

              MaterialPinFormField(
                length: 6,
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: const Size(45, 55),
                  borderRadius: BorderRadius.circular(12),
                  focusedBorderColor: AppColors.primary,
                  focusedFillColor: const Color(0xFFEEF2FF),
                  focusedElevation: 2,
                  fillColor: Colors.black.withValues(alpha: 0.06),
                  textStyle: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Enter full 6 digits';
                  }
                  return null;
                },
                onCompleted: (value) {
                  controller.confirmOTP(value, type);
                },
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Gọi lại hàm gửi OTP ở đây
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}