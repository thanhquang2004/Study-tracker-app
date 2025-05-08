// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileUser _$ProfileUserFromJson(Map<String, dynamic> json) => ProfileUser(
      id: parseString(json['id']),
      username: parseString(json['username']),
      email: parseString(json['email']),
      dob: parseString(json['dob']),
      occupation: parseString(json['occupation']),
    );

Map<String, dynamic> _$ProfileUserToJson(ProfileUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'dob': instance.dob,
      'occupation': instance.occupation,
    };
