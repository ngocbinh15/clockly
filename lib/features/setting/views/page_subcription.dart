import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/features/setting/widgets/plan_option_yearly.dart';
import 'package:clockly/features/setting/widgets/upgrade_pro_button.dart';
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
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    HeadingSetting(text: "Manage Subscription",),
            
                    SizedBox(height: AppSizes.p16,),
            
                    PlanOptionYearly(
                      namePlanOption: "Yearly Pro",
                      costOtion: "\$4.16",
                      infoPlan: "Billed \$49.99 anually",
                      index: 1,
                    ),
            
                      SizedBox(height: AppSizes.p16,),
            
                    PlanOptionYearly(
                      namePlanOption: "Monthly Pro",
                      infoPlan: "Flexible billing",
                      costOtion: "\$4.99",
                      index: 2
                  ),
            
                  SizedBox(height: AppSizes.p16,),
                  UpgradeProButton()
                    
                ]
              ),
          ),
        ),
      )
      );
  }
}
