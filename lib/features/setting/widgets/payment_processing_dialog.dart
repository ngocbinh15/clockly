import 'package:clockly/core/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../controller/option_plan_controller.dart';

class PaymentProcessingDialog extends GetView<OptionPlanController> {
  const PaymentProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.secondary,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.isPaymentProcessing.value)
                const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 4,
                  ),
                )
              else if (controller.paymentSuccess.value)
                 Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 70,
                ),
              
              const SizedBox(height: 24),
              
              Text(
                controller.paymentStatus.value,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ThemeHelper.isDark? Colors.white : Colors.black54,
                ),
              ),

              if (controller.isPaymentProcessing.value) ...[
                const SizedBox(height: 12),
                Text(
                  "Please do not close the app",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ]
            ],
          );
        }),
      ),
    );
  }
}