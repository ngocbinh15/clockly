import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_size.dart';

class PageTeamTask extends StatelessWidget {
  const PageTeamTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsetsGeometry.only(
            top: MediaQuery
                .of(context)
                .padding
                .top + AppSizes.p12,
            left: AppSizes.p24,
            right: AppSizes.p24,
            bottom: AppSizes.p24,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leader Board", style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),),
            Text ("See who completed the most task in your list friends!!", style: GoogleFonts.inter (
              color: AppColors.grey,
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
    );
  }
}
