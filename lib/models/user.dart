class UserProfile {
  final int id;
  final String fullName;
  final String email;
  final String role;
  final int gender;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.gender,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      gender: json['gender'],
    );
  }
}