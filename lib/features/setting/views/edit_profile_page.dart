import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/EditProfileController.dart';
import '../widgets/form_change_name.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.p16),
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondary, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Obx(() {
                        if (controller.selectedImagePath.value.isNotEmpty) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(controller.selectedImagePath.value)),
                          );
                        } else if (controller.avatarUrl.value.isNotEmpty) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(controller.avatarUrl.value),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.grey.withValues(alpha: 0.1),
                            child: Icon(Icons.person_rounded, size: 50, color: AppColors.grey),
                          );
                        }
                      }),
                    ),

                    Container(
                      padding: const EdgeInsets.all(AppSizes.p8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              FormChangeName()
            ],
          ),
        ),
      ),
    );
  }
}