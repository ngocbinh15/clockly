import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/setting/model/integration_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class IntegrationTile extends StatelessWidget {
  const IntegrationTile({super.key, required this.item, required this.isDark});

  final IntegrationModel item;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.p16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: HugeIcon(icon: item.icon, size: 24, color: item.color),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  item.desc,
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: () {
              // Get.snackbar(
              //   "Integrations",
              //   "${item.name} integration will be available soon!",
              //   snackPosition: SnackPosition.TOP,
              //   backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              //   colorText: isDark ? Colors.white : Colors.black,
              // );

              AppAlerts.warning(
                message: "${item.name} integration will be available soon!",
                title: "Integrations",
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: item.isConnected
                  ? Colors.redAccent.withValues(alpha: 0.1)
                  : AppColors.primary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              item.isConnected ? "Disconnect" : "Connect",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: item.isConnected ? Colors.redAccent : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
