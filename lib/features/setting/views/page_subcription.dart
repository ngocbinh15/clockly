import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/features/setting/widgets/plan_option_yearly.dart';
import 'package:flutter/material.dart';

class PageSubcription extends StatelessWidget {
  const PageSubcription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.p16,
            horizontal: AppSizes.p24
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  HeadingSetting(text: "Manage Subcription",),
          
                  SizedBox(height: AppSizes.p16,),

                  PlanOptionYearly()
              ]
            ),
        ),
      )
      );
  }
}
