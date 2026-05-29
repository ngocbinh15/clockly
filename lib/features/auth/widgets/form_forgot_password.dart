import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/custom_text_field.dart';
import '../../../core/components/primary_button.dart';
import '../../../core/constants/app_size.dart';
import '../validators/validate.dart';

class FormForgotPassword extends StatelessWidget {
  FormForgotPassword({super.key});
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final controller = Get.find<ForgotPasswordController>();
  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email Address", style: AppTextStyles.title),
          SizedBox(height: AppSizes.p12),
          CustomTextField(
            txtController: controller.emailController,
            hintText: "name@company.com",
            prefixIcon: HugeIcons.strokeRoundedMail01,
            validator: (value) => Validate.validEmail(value),
          ),

          SizedBox(height: AppSizes.p32),

          PrimaryButton(
            text: "Send Reset Code",
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
            onPressed: () {
              if (formState.currentState!.validate()) {
                Get.focusScope?.unfocus();
                controller.sendPasswordReset();
                controller.emailController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
