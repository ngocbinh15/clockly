import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
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

  static void dialogOTP(OtpType type, String email) {
    final controller = Get.put(OtpController());

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
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedForgotPassword,
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

              Obx(() => MaterialPinField(
                length: 6,
                pinController: controller.pinController,
                errorText: controller.otpErrorText.value,

                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: const Size(45, 55),
                  borderRadius: BorderRadius.circular(AppSizes.p12),

                  focusedBorderColor: AppColors.primary,
                  focusedFillColor: AppColors.secondary,
                  focusedElevation: 0,
                  completeBorderColor: AppColors.grey.withValues(alpha: 0.7),
                  completeFillColor: AppColors.background,
                  filledBorderColor: AppColors.primary.withValues(alpha: 0.4),
                  filledFillColor: AppColors.secondary,
                  borderColor: AppColors.grey.withValues(alpha: 0.4),
                  fillColor: AppColors.background,

                  textStyle: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),

                  errorBorderColor: AppColors.red,
                  errorFillColor: AppColors.red.withValues(alpha: 0.1),
                  errorAnimationDuration: const Duration(milliseconds: 500),
                ),

                onChanged: (value) {
                  if (controller.otpErrorText.value != null) {
                    controller.otpErrorText.value = null;
                  }
                },

                onCompleted: (value) {
                  controller.confirmOTP(value, type, email);
                },

                errorBuilder: (errorText) {
                  if (errorText == null || errorText.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(
                        icon: HugeIcons.strokeRoundedSettingError03,
                          color: AppColors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          errorText,
                          style: GoogleFonts.inter(
                            color: AppColors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),

              SizedBox(height: AppSizes.p24 ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Gọi lại hàm gửi OTP
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