import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/custom_actiom_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFiledAddTask extends StatelessWidget {
  TextFiledAddTask({super.key});

  final controller = Get.find<TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          autofocus: true,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          controller: controller.nameController,
          decoration: InputDecoration(
            hintText: "What do you need to get done?",
            hintStyle: GoogleFonts.inter(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          validator: (value) => Validate.validName(value),
        ),

        TextFormField(
          maxLines: 3,
          minLines: 1,
          controller: controller.decriptionController,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black54,
          ),
          decoration: InputDecoration(
            hintText: "Add description (optional)...",
            hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, bottom: 16),
          ),
        ),

        SizedBox(height: AppSizes.p12,),
      ],
    );
  }
}
