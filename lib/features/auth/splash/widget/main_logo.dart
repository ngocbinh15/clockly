import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p4),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F8),
        borderRadius: BorderRadiusGeometry.circular(AppSizes.p12),
      ),
      width: 100,
      height: 100,
      child: Card(elevation: 1.5, child: Image.asset('assets/images/logo.png')),
    );
  }
}
