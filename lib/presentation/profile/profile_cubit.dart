import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/user_service.dart';
import 'package:study_tracker_mobile/presentation/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserService _userService;

  ProfileCubit(this._userService) : super(ProfileState());

  Future<void> fetchUserProfile() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final user = await _userService.getUserProfile();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}