import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/theme/app_colors.dart';

class LoadingProcess extends StatelessWidget {
  const LoadingProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(AppSizes.p16),
        child: LinearProgressIndicator(
          minHeight: 4,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
