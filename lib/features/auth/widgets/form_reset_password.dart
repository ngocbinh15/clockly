import 'package:clockly/core/components/custom_text_field.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/controllers/forgot_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/primary_button.dart';
import '../../../core/constants/app_size.dart';
import '../validators/validate.dart';

class FormResetPassword extends StatelessWidget {
  FormResetPassword({super.key});

  final GlobalKey <FormState> _formState = GlobalKey <FormState>();
  final controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Form (
      key: _formState,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12),
          CustomTextField(
            txtController: controller.passwordController,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (value) => Validate.validPassword(value),
          ),

          SizedBox(height: AppSizes.p32),
          Text("Confirm Password", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12),
          CustomTextField(
            txtController: controller.confirmPasswordController,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (value) => Validate.confirmPassword(value, controller.passwordController.text),
          ),
          SizedBox(height: AppSizes.p32),

          PrimaryButton(
            text: "Confirm",
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
            onPressed: () {
              if (_formState.currentState!.validate()) {
                Get.focusScope?.unfocus();
                controller.resetPassword();
                controller.passwordController.clear();
                controller.confirmPasswordController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
