import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/edit_profile_controller.dart';
import '../widgets/editable_avatar.dart';
import '../widgets/heading_setting.dart';
import '../widgets/form_change_name.dart';

class PageEditProfile extends GetView<EditProfileController> {
  const PageEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadingSetting(text: "Edit Profile"),

              const SizedBox(height: 40),

              const EditableAvatar(),

              const SizedBox(height: 40),

              FormChangeName(),
            ],
          ),
        ),
      ),
    );
  }
}