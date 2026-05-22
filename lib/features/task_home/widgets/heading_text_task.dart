import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/text_heading.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class HeadingTextTask extends StatelessWidget {
  const HeadingTextTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextHeading(textHeading: "My Tasks"),
        IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.chat);
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedChatAdd01,
              size: 30,
              strokeWidth: 1.8,
              color: AppColors.primary,
            )
        )
      ],
    );
  }
}
