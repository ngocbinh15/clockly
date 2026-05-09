import 'package:clockly/core/components/custom_text_field.dart';
import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class FormLogin extends GetView<LoginController> {
  FormLogin({super.key});

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

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
          txtController: txtEmail,
            hintText: "name@company.com",
            prefixIcon: HugeIcons.strokeRoundedMail01,
            validator: (value) => controller.validEmail(value),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Password", style: AppTextStyles.title),
              TextButton(
                onPressed: () {
                  // TODO: Xử lý logic chuyển trang Forgot Password
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.p12),
          CustomTextField(
            txtController: txtPassword,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (value) => controller.validPassword(value),
          ),

          const SizedBox(height: 32),

          PrimaryButton(
            text: "Sign In",
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
            onPressed: () {
              if (formState.currentState!.validate()) {
                // controller.login(txtEmail.text, txtPassword.text);
              }
            },
          ),
        ],
      ),
    );
  }
}