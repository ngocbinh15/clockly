import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/components/custom_text_field.dart';
import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class FormLogin extends GetView<LoginController> {
  FormLogin({super.key});

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

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

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Password", style: AppTextStyles.title),
              CustomTextButton(
                  color: AppColors.primary,
                  text: "Forgot password?",
                  onTap: () => Get.toNamed(AppRoutes.forgotPassword),
              )
            ],
          ),
          SizedBox(height: AppSizes.p12),
          CustomTextField(
            txtController: controller.passwordController,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (value) => Validate.validPassword(value),
          ),

          SizedBox(height: AppSizes.p32),

          PrimaryButton(
            text: "Sign In",
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
            onPressed: () {
              if (formState.currentState!.validate()) {
                Get.focusScope?.unfocus();
                controller.signIn();
                controller.passwordController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}