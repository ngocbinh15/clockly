import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:clockly/features/setting/widgets/subcription_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
    
class PlanOptionYearly extends GetView<OptionPlanController> {
  PlanOptionYearly({
      super.key,
      required this.namePlanOption,
      required this.infoPlan,
      required this.costOtion,
      required this.index
    });

  final String namePlanOption, infoPlan, costOtion;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        bool isChoose = controller.IsChoose.value == index;
        Color colorText = ThemeHelper.isDark ? Colors.white : Colors.black87;
        Color subTextColor = ThemeHelper.isDark ? Colors.white54 : Colors.black54;
        
        return GestureDetector(
            onTap: () {
              controller.IsChoose.value = index;
            },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100), 
            margin: const EdgeInsets.only(bottom: AppSizes.p16), 
            padding: const EdgeInsets.all(AppSizes.p24),
            decoration: BoxDecoration(
              color: isChoose ? AppColors.primary.withValues(alpha: 0.1) : AppColors.secondary,
              border: Border.all(
                color: isChoose 
                    ? AppColors.primary 
                    : (ThemeHelper.isDark ? Colors.transparent : Colors.grey.shade200),
                width: isChoose ? 2 : 1, 
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namePlanOption, 
                      style: GoogleFonts.inter(
                        color: colorText,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                    )),
                  
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic, 
                      children: [
                          Text(
                          costOtion, 
                          style: GoogleFonts.inter(
                              fontSize: 28,
                              color: isChoose ? AppColors.primary : colorText, 
                              fontWeight: FontWeight.w800
                          ),
                          ),
                          
                          const SizedBox(width: AppSizes.p4), 
                          
                          Text(
                          "/mo", 
                          style: GoogleFonts.inter(
                              color: colorText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600, 
                          ),
                          )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.p4),
                Text(
                  infoPlan, 
                  style: GoogleFonts.inter(
                    color: subTextColor, 
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),

                const SizedBox(height: AppSizes.p24), 

                SubcriptionInfo(
                  index: index,
                  name: "Unlimited Tasks"
                ),
                SubcriptionInfo(
                  index: index,
                  name: "Clockly AI Assistant" 
                ),
                SubcriptionInfo(
                  index: index,
                  name: "Advanced Analytics" 
                ),
                SubcriptionInfo(
                  index: index,
                  name: "Multi-device Sync"
                )

                
              ],
            ),
          ),
        );
      });
  }
}