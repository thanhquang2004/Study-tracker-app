import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/register/cubit/register_state.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/loading_dialog.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _authService = AuthService();
  RegisterCubit()
      : super(RegisterState(
          usernameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dobController: TextEditingController(),
          occupation: "",
        ));

  void setOccupation(String value) {
    print('Occupation selected: $value');
    emit(state.copyWith(occupation: value));
    print('Occupation in state: ${state.occupation}');
  }

  Future<void> register() async {
    try {
      Get.dialog(LoadingDialog());
      final data = {
        'username': state.usernameController.text,
        'email': state.emailController.text,
        'name': state.usernameController.text,
        'dob': state.dobController.text,
        'password': state.passwordController.text,
        'occupation': state.occupation,
      };
      await _authService.signUp(
        data,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          Get.back();
          emit(state.copyWith(
            isError: true,
            errorMessage: "Hệ thống đang bận, vui lòng thử lại sau",
          ));
          return;
        },
      );
      Get.back();
      emit(state.copyWith(
        isError: false,
        errorMessage: "",
      ));
      Get.offAllNamed(Routes.loginRoute);
    } catch (e) {
      Get.back();
      emit(state.copyWith(
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  void navigateToLogin() {
    Get.offAllNamed(Routes.loginRoute);
  }
}
