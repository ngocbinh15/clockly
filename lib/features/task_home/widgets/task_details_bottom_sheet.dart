import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:clockly/core/utils/theme_helper.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dialog_helper.dart';
import '../controllers/task_home_controller.dart';
import '../model/task.dart';
import '../model/task_category.dart';
import 'edit_task_bottom_sheet.dart';
import 'list_avatar.dart';

class TaskDetailsBottomSheet extends GetView<TaskHomeController> {
	final TaskModel task;
	final bool isTeamTask;
	final List<String> listAvatars;

	const TaskDetailsBottomSheet({
		super.key,
		required this.task,
		required this.isTeamTask,
		required this.listAvatars,
	});

	@override
	Widget build(BuildContext context) {
		return Obx(() {
			final isDark = ThemeHelper.isDark;
			return Container(
				padding: const EdgeInsets.all(AppSizes.p24),
				decoration: BoxDecoration(
					color: AppColors.secondary,
					borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
				),
				child: SafeArea(
				child: Column(
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Center(
							child: Container(
								width: 50,
								height: 5,
								decoration: BoxDecoration(
									color: AppColors.grey.withValues(alpha: 0.3),
									borderRadius: BorderRadius.circular(10),
								),
							),
						),
						const SizedBox(height: AppSizes.p24),

						Text(
							task.title,
							style: GoogleFonts.inter(
								fontSize: 24,
								fontWeight: FontWeight.w800,
								color: isDark ? Colors.white : Colors.black87,
								height: 1.3,
							),
						),
						const SizedBox(height: AppSizes.p16),

						Row(
							children: [
								Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
									decoration: BoxDecoration(
										color: task.category.color.withValues(alpha: 0.1),
										borderRadius: BorderRadius.circular(10),
									),
									child: Text(
										task.category.displayName.toUpperCase(),
										style: GoogleFonts.inter(
											color: task.category.color,
											fontSize: 12,
											fontWeight: FontWeight.bold,
											letterSpacing: 0.5,
										),
									),
								),
								const SizedBox(width: AppSizes.p12),

								Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
									decoration: BoxDecoration(
										color: _getPriorityColor(task.priority).withValues(alpha: 0.1),
										borderRadius: BorderRadius.circular(10),
									),
									child: Row(
										children: [
											Icon(Icons.flag_rounded, size: 16, color: _getPriorityColor(task.priority)),
											const SizedBox(width: 6),
											Text(
												task.priority.toUpperCase(),
												style: GoogleFonts.inter(
													color: _getPriorityColor(task.priority),
													fontSize: 12,
													fontWeight: FontWeight.bold,
													letterSpacing: 0.5,
												),
											),
										],
									),
								),
							],
						),

						const SizedBox(height: AppSizes.p24),

						Divider(color: AppColors.grey.withValues(alpha: 0.15), height: 1),
						const SizedBox(height: AppSizes.p20),

						TextTitleAddTask(text: "Description",),
						const SizedBox(height: AppSizes.p8),
						Text(
							(task.description ?? '').isEmpty ? "No description provided." : task.description!,
							style: GoogleFonts.inter(
								fontSize: 15,
								color: (task.description ?? '').isEmpty ? AppColors.grey : (isDark ? Colors.white70 : Colors.black87),
								height: 1.6,
							),
						),

						const SizedBox(height: AppSizes.p24),

						Container(
							padding: const EdgeInsets.all(AppSizes.p16),
							decoration: BoxDecoration(
								color: AppColors.background,
								borderRadius: BorderRadius.circular(16),
								border: Border.all(color: AppColors.grey.withValues(alpha: 0.1)),
							),
							child: Row(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									Expanded(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													"Due Date",
													style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.third),
												),
												const SizedBox(height: AppSizes.p8),
												Row(
													children: [
														Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.primary),
														const SizedBox(width: 8),
														Text(
															controller.formatTime(task.dueDate),
															style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black87),
														),
													],
												),
											],
										),
									),

									if (isTeamTask) ...[
										Container(width: 1, height: 40, color: AppColors.grey.withValues(alpha: 0.2)),
										const SizedBox(width: 16),
										Expanded(
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														"Assignees",
														style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.third),
													),
													const SizedBox(height: AppSizes.p8),
													ListAvatar(avatarUrls: listAvatars),
												],
											),
										),
									]
								],
							),
						),

						const SizedBox(height: AppSizes.p32),

						Row(
							children: [
								Expanded(
									child: TextButton.icon(
										onPressed: () {
											Get.back();
											CustomDialog.confirmDialog(
												title: "Delete task?",
												content: "This will permanently delete this task. You can’t undo this action.",
												cancel: "Cancel",
												confirm: "Delete",
												onConfirm: () => controller.deleteTask(task),
											);
										},
										style: TextButton.styleFrom(
											padding: const EdgeInsets.symmetric(vertical: 16),
											backgroundColor: AppColors.fouth.withValues(alpha: 0.1),
											foregroundColor: AppColors.fouth,
											shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
										),
										icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete02, color: AppColors.fouth, size: 20),
										label: Text("Delete", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
									),
								),

								const SizedBox(width: 16),

								Expanded(
									child: ElevatedButton.icon(
										onPressed: () {
											Get.back();

											controller.prepareEditData(task);

											Get.bottomSheet(
													EditTaskBottomSheet(task: task),
													isScrollControlled: true,
													backgroundColor: Colors.transparent,
													ignoreSafeArea: false
											);
										},
										style: ElevatedButton.styleFrom(
											padding: const EdgeInsets.symmetric(vertical: 16),
											backgroundColor: AppColors.primary,
											foregroundColor: Colors.white,
											elevation: 0,
											shadowColor: Colors.transparent,
											shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
										),
										icon: const Icon(Icons.edit_rounded, size: 20),
										label: Text("Edit Task", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
									),
								),
							],
						),
					],
				),
			),
		);
		});
	}

	Color _getPriorityColor(String priority) {
		switch (priority.toLowerCase()) {
			case 'high':
				return Colors.red;
			case 'medium':
				return Colors.orange;
			case 'low':
				return Colors.green;
			default:
				return AppColors.grey;
		}
	}
}