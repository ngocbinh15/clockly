import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/EditProfileController.dart';
import '../widgets/edit_profile_header.dart';
import '../widgets/editable_avatar.dart';
import '../widgets/form_change_name.dart'; // Import Form của bạn

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const EditProfileHeader(),

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