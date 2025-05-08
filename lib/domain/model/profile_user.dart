import 'package:json_annotation/json_annotation.dart';
import 'package:study_tracker_mobile/data/helpers/parsing_helper.dart';
part 'profile_user.g.dart';

@JsonSerializable()
class ProfileUser {
  @JsonKey(name: 'id', fromJson: parseString)
  final String id;
  @JsonKey(name: 'username', fromJson: parseString)
  final String username;
  @JsonKey(name: 'email', fromJson: parseString)
  final String email;
  @JsonKey(name: 'dob', fromJson: parseString)
  final String dob;
  @JsonKey(name: 'occupation', fromJson: parseString)
  final String occupation;

  const ProfileUser({
    required this.id,
    required this.username,
    required this.email,
    required this.dob,
    required this.occupation,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) => _$ProfileUserFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileUserToJson(this);
}
