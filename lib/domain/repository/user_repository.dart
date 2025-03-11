import 'package:study_tracker_mobile/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
}