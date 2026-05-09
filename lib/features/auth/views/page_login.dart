import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/widgets/form_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageLogin extends GetView <LoginController> {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF1F5F9),
              Color(0xFFD6DEE8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 1.5,
                color: AppColors.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.p24, vertical: AppSizes.p32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextHeading(
                        textHeading: "Welcome Back",
                      ),
                      FormLogin()
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}