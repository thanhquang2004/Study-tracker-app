import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RegisterState extends Equatable {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isRemember;
  final bool isError;
  final String errorMessage;

  const RegisterState({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isRemember = false,
    this.isError = false,
    this.errorMessage = '',
  });

  RegisterState copyWith({
    TextEditingController? fullNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isRemember,
    bool? isError,
    String? errorMessage,
  }) {
    return RegisterState(
      fullNameController: fullNameController ?? this.fullNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isRemember: isRemember ?? this.isRemember,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullNameController,
        emailController,
        passwordController,
        confirmPasswordController,
        isPasswordVisible,
        isConfirmPasswordVisible,
        isRemember,
        isError,
        errorMessage,
      ];
}
