import 'package:study_tracker_mobile/domain/model/profile_user.dart';

abstract class UserRepository {
  Future<ProfileUser> getUserProfile();
}