import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clockly/core/theme/app_colors.dart';

class PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
  });

  final List<String> priorities = const ['Low', 'Medium', 'High'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleAddTask(text: "Priority"),

        SizedBox(height: AppSizes.p12),

        Container(
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.grey.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: priorities.map((priority) {
              final isSelected = selectedPriority == priority;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(priority),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      priority,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isSelected ? AppColors.primary : AppColors.grey,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}