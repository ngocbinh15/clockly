import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/analys/controller/analys_controller.dart';
import 'package:clockly/features/analys/widget/custom_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'note_chart.dart';


class CustomPieChart extends GetView <AnalysController> {
  const CustomPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 373,
      padding: EdgeInsetsGeometry.all(AppSizes.p24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Task Distribution", style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),

          CustomChart (),

          SizedBox(height: AppSizes.p4,),

          NoteChart()
        ],
      ),
    );
  }
}
