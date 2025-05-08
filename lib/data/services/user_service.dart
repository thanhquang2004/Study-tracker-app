import 'dart:core';

import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/model/profile_user.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class UserService {
  final _api = GetIt.I.get<ApiService>();

  Future<ProfileUser> getUserProfile() async {
    try {
      final response = await _api.get(ApiManager.profile);
      if (response.statusCode == 200) {
        final data = response.data['result'];
        if (data == null) {
          throw Exception('User data is null');
        }
        return ProfileUser.fromJson(data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      throw Exception('Error fetching user profile: $e');
    }
  }

  // Example method to update user profile
  Future<void> updateUserProfile(dynamic data) async {
    // Logic to update user profile in the database or API
  }
}
