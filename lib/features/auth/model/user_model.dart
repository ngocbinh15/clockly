class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final int totalPoints;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    this.totalPoints = 0,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? 'Người dùng',
      email: map['email'] ?? '',
      avatarUrl: map['avatar_url'],
      totalPoints: map['total_points'] ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }
}