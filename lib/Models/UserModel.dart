class UserModel {
  final int? id;
  final String? email;
  final String? password;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? roleId;
  final bool? isEnabled;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.isEnabled,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      roleId: json['roleId'],
      isEnabled: json['isEnabled'],
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'roleId': roleId,
      'isEnabled': isEnabled,
    };
  }
}
