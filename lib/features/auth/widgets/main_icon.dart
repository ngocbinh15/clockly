import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class MainIcon extends StatelessWidget {
  MainIcon({super.key, required this.icon});

  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: HugeIcon(
        icon: icon,
        color: AppColors.primary,
        size: 40,
      ),
    );
  }
}
