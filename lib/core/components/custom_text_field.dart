import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomTextField extends GetView<LoginController> {

  final TextEditingController txtController;
  final String hintText;
  final dynamic prefixIcon;
  final bool isPassword;

  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.txtController,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFCBD5E1),
        width: 1.5,
      ),
    );

    return Obx(
            () {
          bool obscure = controller.obscurePassword.value;
          return TextFormField(
            controller: txtController,

            obscureText: isPassword
                ? obscure
                : false,

            decoration: InputDecoration(
              hintText: hintText,

              hintStyle: GoogleFonts.inter(
                  color: Colors.grey,
                  letterSpacing: 1
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),

              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                ),
                child: HugeIcon(
                  icon: prefixIcon,
                  color: const Color(0xFF64748B),
                ),
              ),

              prefixIconConstraints:
              const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),

              suffixIcon: isPassword ?
              IconButton(
                onPressed: () {
                  controller.obscurePassword.toggle();
                },

                icon: HugeIcon(
                  icon: obscure
                      ? HugeIcons
                      .strokeRoundedViewOff
                      : HugeIcons
                      .strokeRoundedView,

                  color: const Color(0xFF64748B),
                ),
              ) : null,

              border: borderStyle,
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
            ),

            validator: validator,
          );
        }
    );
  }
}