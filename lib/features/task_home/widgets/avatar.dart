import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({super.key, required this.avatarURL});

  String avatarURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.grey,
      child: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(
          avatarURL
        ),
      ),
    );
  }
}