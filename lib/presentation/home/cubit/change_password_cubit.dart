import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthService authService = AuthService();

  ChangePasswordCubit() : super(ChangePasswordState());

  void toggleOldPasswordVisibility() {
    emit(state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Vui lòng điền đầy đủ thông tin',
      ));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(
        state.copyWith(
          errorMessage: "Xác nhận mật khẩu không khớp",
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      await authService.changePassword(
        currentPassword,
        newPassword,
        confirmPassword,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
