class UserModel {
  String id, full_name, email, role;

  UserModel({
    required this.id,
    required this.full_name,
    required this.email,
    required this.role
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'full_name': this.full_name,
      'email': this.email,
      'role': this.role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      full_name: map['full_name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
    );
  }

}