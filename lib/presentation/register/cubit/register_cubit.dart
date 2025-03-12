import 'dart:math';

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
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
        ));

  Future<void> register() async {
    try {
      Get.dialog(LoadingDialog());
      await _authService.signUp(
        state.fullNameController.text,
        state.emailController.text,
        state.passwordController.text,
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

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, Routes.loginRoute);
  }
}
