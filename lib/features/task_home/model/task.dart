import 'task_category.dart';

class TaskModel {
	final String id;
	final String profileId;
	final String title;
	final String? description;
	final TaskCategory category;
	final String status;
	final String priority;
	final DateTime? dueDate;
	final DateTime createdAt;

	TaskModel({
		required this.id,
		required this.profileId,
		required this.title,
		this.description,
		this.category = TaskCategory.general,
		this.status = 'pending',
		this.priority = 'medium',
		this.dueDate,
		required this.createdAt,
	});

	factory TaskModel.fromMap(Map<String, dynamic> map) {
		return TaskModel(
			id: map['id'] as String,
			profileId: map['profile_id'] as String,
			title: map['title'] as String,
			description: map['description'] as String?,

			category: categoryFromDb(map['category'] as String?),

			status: map['status'] as String? ?? 'pending',
			priority: map['priority'] as String? ?? 'medium',

			dueDate: map['due_date'] != null
					? DateTime.parse(map['due_date'] as String).toLocal()
					: null,
			createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
		);
	}

	Map<String, dynamic> toMap() {
		return {
			'profile_id': profileId,
			'title': title,
			'description': description,
			'category': category.dbValue,
			'status': status,
			'priority': priority,
			'due_date': dueDate?.toUtc().toIso8601String(),
		};
	}
}