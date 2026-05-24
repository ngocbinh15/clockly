import 'package:clockly/features/page_chat/widgets/heading_chat.dart';
import 'package:clockly/features/page_chat/widgets/main_chat_body.dart';
import 'package:clockly/features/page_chat/widgets/messager_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';

import '../../../core/constants/app_size.dart';

class PageChat extends StatelessWidget {
  const PageChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Get.focusScope?.unfocus(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSizes.p12,
                    left: AppSizes.p24,
                    right: AppSizes.p24,
                  ),
                  child: const HeadingChat(),
                ),

                const SizedBox(height: AppSizes.p16),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
                    child: const MainChatBody(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizes.p12,
                  ),
                  child: const CustomMessagerBar(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}