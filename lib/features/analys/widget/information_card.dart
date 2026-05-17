import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomInformationCard extends GetView <AnalysController> {
  CustomInformationCard({super.key, required this.icon, required this.taskCount, required this.label, required this.color});

  int taskCount;
  String label;
  dynamic icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppSizes.p16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              shape: BoxShape.circle
            ),
            child: Center(
              child: HugeIcon(
                  icon: icon,
                color: color,
              ),
            ),
          ),

          SizedBox(height: AppSizes.p8,),

          Text ("$taskCount", style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),

          SizedBox(height: AppSizes.p8,),

          Text(label, style: GoogleFonts.inter (
            color: Colors.black87.withValues(alpha: 0.5)
          ),)
        ],
      ),
    );
  }
}
