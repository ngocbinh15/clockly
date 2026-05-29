import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';

class MainTheme extends StatelessWidget {
  const MainTheme({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.p24),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.p16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.p24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.p24,
                          vertical: AppSizes.p32,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppSizes.p24),
                        ),
                        child: body,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
