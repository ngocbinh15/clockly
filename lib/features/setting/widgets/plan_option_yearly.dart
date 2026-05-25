import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
    
class PlanOptionYearly extends GetView<OptionPlanController> {
  const PlanOptionYearly({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        bool isChoose = controller.IsChoose.value == 1;
        Color colorText = ThemeHelper.isDark? Colors.white : Colors.black87;
        
        return GestureDetector(
            onTap: () {
              controller.IsChoose.value = 1;
            },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p24,
              vertical: AppSizes.p20
            ),
            decoration: BoxDecoration(
              color: isChoose ? AppColors.primary.withValues(alpha: 0.18) : (ThemeHelper.isDark ? Colors.black54 : Colors.white),
              border: Border.all(
                color: isChoose 
                    ? AppColors.primary 
                    : (ThemeHelper.isDark ? Colors.black54 : Colors.white),
              ),
              borderRadius: BorderRadius.circular(AppSizes.p16),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Yearly Pro", style: GoogleFonts.inter(
                        color: colorText,
                        fontSize: 30,
                        fontWeight: FontWeight.w700
                    )),
                  
                  
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic, 
                      
                      children: [
                          Text(
                          "\$4.16", 
                          style: GoogleFonts.inter(
                              fontSize: 28,
                              color: isChoose ? AppColors.primary : (ThemeHelper.isDark ? Colors.white : Colors.black87), 
                              fontWeight: FontWeight.w700
                          ),
                          ),
                          
                          const SizedBox(width: 4), 
                          
                          Text(
                          "/mo", 
                          style: GoogleFonts.inter(
                              color: colorText,
                              fontSize: 18,
                              fontWeight: FontWeight.w500, 
                          ),
                          )
                      ],
                      ),
                    ],
                  ),

                    Text("Billed \$49.99 anually", style: GoogleFonts.inter(
                        color: colorText
                    ),),


              ],
            ),
          ),
        );
      });
  }
}