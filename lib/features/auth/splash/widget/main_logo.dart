import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/theme/app_colors.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p4),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadiusGeometry.circular(AppSizes.p12)
      ),
      width: 100,
      height: 100,
      child: Card(
        elevation: 1.5,
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
