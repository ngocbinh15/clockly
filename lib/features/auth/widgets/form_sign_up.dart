import 'package:clockly/core/components/custom_text_field.dart';
import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:clockly/features/auth/controllers/sign_up_controller.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/features/auth/widgets/bottom_button.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class FormSignUp extends StatelessWidget {
  FormSignUp({super.key});

  final GlobalKey <FormState> _formState = GlobalKey <FormState>();
  final controller = Get.find <SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Form (
      key: _formState,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text ("Full Name", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12,),
          CustomTextField(
              txtController: controller.nameController,
              hintText: "John Doe",
              prefixIcon: HugeIcons.strokeRoundedUserSquare,
            validator: (p0) =>  Validate.validName(p0),
          ),

          SizedBox(height: AppSizes.p24,),
          Text ("Email", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12,),
          CustomTextField(
              txtController: controller.emailController,
              hintText: "john@gmail.com",
              prefixIcon: HugeIcons.strokeRoundedMail01,
            validator: (p0) => Validate.validEmail(p0),
          ),

          SizedBox(height: AppSizes.p24,),
          Text ("Password", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12,),
          CustomTextField(
            txtController: controller.passwordController,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (p0) => Validate.validPassword(p0),
          ),

          SizedBox(height: AppSizes.p24,),
          Text ("Confirm Password", style: AppTextStyles.title,),
          SizedBox(height: AppSizes.p12,),
          CustomTextField(
            txtController: controller.confirmController,
            hintText: "••••••••",
            prefixIcon: HugeIcons.strokeRoundedLockPassword,
            isPassword: true,
            validator: (p0) => Validate.confirmPassword(p0, controller.passwordController.text),
          ),

          SizedBox(height: AppSizes.p24,),
          PrimaryButton(
            text: "Sign Up",
            suffixIcon: HugeIcons.strokeRoundedArrowRight01,
            onPressed: () {
              if (_formState.currentState!.validate()) {
                Get.focusScope?.unfocus();
                controller.onRegisterPressed();
              }
            },
          ),
          SizedBox(height: AppSizes.p24,),
          BottomButton(
              leftText: "Already have an account?",
              buttonText: "Log In",
              onTap: () => Get.offAllNamed(AppRoutes.login),
          )
        ],
      ),
    );
  }
}
