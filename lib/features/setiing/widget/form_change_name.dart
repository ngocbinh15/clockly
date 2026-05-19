import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/features/setiing/controller/EditProfileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_size.dart';

class FormChangeName extends GetView <EditProfileController> {
  FormChangeName({super.key});

  GlobalKey <FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form (
          key: _formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
            TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
              hintText: "Full Name",

              hintStyle: GoogleFonts.inter(
                  color: Colors.grey,
                  letterSpacing: 1
              ),
              filled: true,
              fillColor: AppColors.secondary,

              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserSquare,
                  color: const Color(0xFF64748B),
                ),
              ),

              prefixIconConstraints:
              const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFCBD5E1),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFCBD5E1),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFCBD5E1),
                  width: 1.5,
                ),
              ),
            ),

            validator: (value) =>  Validate.validName(value),
          ),

              SizedBox(height: AppSizes.p32,),

              PrimaryButton (
                text: "Save Change",
                onPressed: () async{
                  if (_formState.currentState!.validate()) {
                    controller.saveProfile();
                    Get.focusScope?.unfocus();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
