import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginState extends Equatable {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRemember;
  final bool isPasswordVisible;
  final bool isError;
  final String errorMessage;

  const LoginState({
    required this.emailController,
    required this.passwordController,
    this.isRemember = false,
    this.isPasswordVisible = false,
    this.isError = false,
    this.errorMessage = '',
  });

  // CopyWith để cập nhật state
  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isRemember,
    bool? isPasswordVisible,
    bool? isError,
    String? errorMessage,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isRemember: isRemember ?? this.isRemember,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        isRemember,
        isPasswordVisible,
        isError,
        errorMessage,
      ];
}
