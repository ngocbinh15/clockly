import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/components/text_title.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/splash_controller.dart';
import 'package:clockly/features/auth/splash/widget/bottom_text.dart';
import 'package:clockly/features/auth/splash/widget/loading_process.dart';
import 'package:clockly/features/auth/splash/widget/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageSplash extends GetView<SplashController> {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          gradient: RadialGradient(
            center: Alignment(0.0, -0.2),
            radius: 1.7,
            colors: [
              Color(0xFFA9AAE7),
              Color(0xFFF3F5FF),
              AppColors.background,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            const MainLogo(),
            SizedBox(height: AppSizes.p16),
            TextHeading(textHeading: "Clockly"),
            SizedBox(height: AppSizes.p16),
            TextTitle(titleText: "Smart Attendance & Workforce Management"),
            const Spacer(flex: 4),
            const LoadingProcess(),
            SizedBox(height: AppSizes.p16),
            const BottomText(),
            SizedBox(height: AppSizes.p40),
          ],
        ),
      ),
    );
  }
}
