import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ListAvatar extends StatelessWidget {
  ListAvatar({super.key, required this.avatarUrls});

  List<String> avatarUrls;

  @override
  Widget build(BuildContext context) {
    const int maxDisplay = 3;
    final int displayCount = avatarUrls.length > maxDisplay ? maxDisplay : avatarUrls.length;

    const double avatarSize = 24.0;
    const double overlap = 10.0;
    return SizedBox(
      width: avatarSize + (displayCount - 1) * (avatarSize - overlap),
      height: avatarSize,
      child: Stack(
        children: List.generate(displayCount, (index) {
          return Positioned(
            left: index * (avatarSize - overlap),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: CircleAvatar(
                radius: (avatarSize - 3) / 2,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                backgroundImage: NetworkImage(avatarUrls[index]),
              ),
            ),
          );
        }).reversed.toList(),
      ),
    );
  }
}
