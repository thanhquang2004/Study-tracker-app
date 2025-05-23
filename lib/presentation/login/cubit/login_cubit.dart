
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_state.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/loading_dialog.dart';

class LoginCubit extends Cubit<LoginState> {
  final storage = GetIt.instance<FlutterSecureStorage>();
  final _authService = AuthService();
  LoginCubit()
      : super(LoginState(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        )) {
    _init(); // Gọi ngay khi cubit được khởi tạo
  }

  /// Hàm khởi tạo, kiểm tra `isRemember` và load dữ liệu nếu cần
  Future<void> _init() async {
    debugPrint("Init Cubit");
    final isRemember = await storage.read(key: "isRemember") == "true";
    if (isRemember) {
      await loadSavedCredentials();
    } else {
      emit(state.copyWith(isRemember: false));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleRemember() {
    storage.write(key: "isRemember", value: (!state.isRemember).toString());
    emit(state.copyWith(
      isRemember: !state.isRemember,
    ));
  }

  // Load dữ liệu từ storage khi remember me đưthaợc bật
  Future<void> loadSavedCredentials() async {
    final email = await storage.read(key: "email") ?? "";
    final password = await storage.read(key: "password") ?? "";
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(isRemember: false));
      return;
    }
    Future.delayed(
      const Duration(milliseconds: 500),
    );
    emit(state.copyWith(
      emailController: TextEditingController(text: email),
      passwordController: TextEditingController(text: password),
      isRemember: true,
    ));
  }

  Future<void> clearSavedCredentials() async {
    await storage.write(key: "isRemember", value: "false");
    await storage.delete(key: "email");
    await storage.delete(key: "password");
  }

  Future<void> saveCredentials() async {
    await storage.write(key: "email", value: state.emailController.text);
    await storage.write(key: "password", value: state.passwordController.text);
  }

  Future<void> login() async {
    try {
      Get.dialog(LoadingDialog());
      await _authService.signIn(
        state.emailController.text.trim(),
        state.passwordController.text.trim(),
      );
      Get.back();
      emit(state.copyWith(isError: false));
      if (state.isRemember) {
        await saveCredentials();
      } else {
        await clearSavedCredentials();
      }
      Get.offAllNamed(Routes.mainRoute);
    } catch (e) {
      Get.back();
      await clearSavedCredentials();
      emit(state.copyWith(isError: true, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
