import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RegisterState extends Equatable {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String occupation;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isRemember;
  final bool isError;
  final String errorMessage;

  const RegisterState({
    required this.usernameController,
    required this.emailController,
    required this.dobController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.occupation,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isRemember = false,
    this.isError = false,
    this.errorMessage = '',
  });

  RegisterState copyWith({
    TextEditingController? usernameController,
    TextEditingController? emailController,
    TextEditingController? dobController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    String? occupation,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isRemember,
    bool? isError,
    String? errorMessage,
  }) {
    return RegisterState(
      usernameController: usernameController ?? this.usernameController,
      emailController: emailController ?? this.emailController,
      dobController: dobController ?? this.dobController,
      occupation: occupation ?? this.occupation,
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
        usernameController,
        emailController,
        passwordController,
        dobController,
        occupation,
        confirmPasswordController,
        isPasswordVisible,
        isConfirmPasswordVisible,
        isRemember,
        isError,
        errorMessage,
      ];
}
