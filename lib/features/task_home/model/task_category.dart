import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

enum TaskCategory {
  all,
  general,
  study,
  coding,
  teaching,
  work,
  health,
  personal,
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.general:
        return 'General';
      case TaskCategory.all:
        return 'All Tasks';
      case TaskCategory.study:
        return 'Study';
      case TaskCategory.coding:
        return 'Coding';
      case TaskCategory.teaching:
        return 'Teaching';
      case TaskCategory.work:
        return 'Work';
      case TaskCategory.health:
        return 'Health';
      case TaskCategory.personal:
        return 'Personal';
    }
  }

  String get dbValue {
    return name;
  }

  dynamic get icon {
    switch (this) {
      case TaskCategory.general:
        return HugeIcons.strokeRoundedTask01;
      case TaskCategory.all:
        return HugeIcons.strokeRoundedBorderFull;
      case TaskCategory.study:
        return HugeIcons.strokeRoundedBookOpen01;
      case TaskCategory.coding:
        return HugeIcons.strokeRoundedCodeCircle;
      case TaskCategory.teaching:
        return HugeIcons.strokeRoundedPresentation02;
      case TaskCategory.work:
        return HugeIcons.strokeRoundedBriefcase02;
      case TaskCategory.health:
        return HugeIcons.strokeRoundedHeartAdd;
      case TaskCategory.personal:
        return HugeIcons.strokeRoundedHome01;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.all:
        return const Color(0xFF6750A4);

      case TaskCategory.general:
        return const Color(0xFF78909C);

      case TaskCategory.study:
        return const Color(0xFF4F6BED);

      case TaskCategory.coding:
        return const Color(0xFF7E57C2);

      case TaskCategory.teaching:
        return const Color(0xFFFFB74D);

      case TaskCategory.work:
        return const Color(0xFF5C6BC0);

      case TaskCategory.health:
        return const Color(0xFFE57373);

      case TaskCategory.personal:
        return const Color(0xFF66BB6A);
    }
  }
}

TaskCategory categoryFromDb(String? dbValue) {
  if (dbValue == null) return TaskCategory.general;

  return TaskCategory.values.firstWhere(
    (e) => e.dbValue.toLowerCase() == dbValue.toLowerCase(),
    orElse: () => TaskCategory.general,
  );
}
