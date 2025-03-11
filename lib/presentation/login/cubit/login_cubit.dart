import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final storage = GetIt.instance<FlutterSecureStorage>();
  LoginCubit()
      : super(LoginState(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        )) {
    _init(); // Gọi ngay khi cubit được khởi tạo
  }

  /// Hàm khởi tạo, kiểm tra `isRemember` và load dữ liệu nếu cần
  Future<void> _init() async {
    debugPrint("Init LoginCubit");
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
    saveCredentials();
  }

  // Load dữ liệu từ storage khi remember me được bật
  Future<void> loadSavedCredentials() async {
    final email = await storage.read(key: "email") ?? "";
    final password = await storage.read(key: "password") ?? "";
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(isRemember: false));
      return;
    }
    emit(state.copyWith(
      emailController: TextEditingController(text: email),
      passwordController: TextEditingController(text: password),
      isRemember: true,
    ));
  }

  Future<void> saveCredentials() async {
    await storage.write(key: "email", value: state.emailController.text);
    await storage.write(key: "password", value: state.passwordController.text);
  }

  //Fake login
  Future<void> login() async {
    const fakeEmail = "bang";
    const fakePassword = "bang";
    Future.delayed(const Duration(seconds: 3));
    if (state.emailController.text == fakeEmail &&
        state.passwordController.text == fakePassword) {
      if (state.isRemember) {
        await saveCredentials();
      } else {
        await storage.delete(key: "email");
        await storage.delete(key: "password");
      }
      emit(state.copyWith(errorMessage: ""));
      print("✅ Đăng nhập thành công!");
    } else {
      emit(state.copyWith(errorMessage: "❌ Email hoặc mật khẩu sai"));
    }
  }

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
