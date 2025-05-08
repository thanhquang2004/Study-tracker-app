class ProfileUser {
  final String id;
  final String userId;
  final String username;
  final String email;
  final String name;
  final DateTime dob;
  final String gender;
  final int age;
  final String occupation;

  const ProfileUser({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.name,
    required this.dob,
    required this.gender,
    required this.age,
    required this.occupation,
  });
}