import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/layout/auth_layout.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/authen_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return AuthenticateLayout(
      title: AppStrings.register,
      listTextField: [
        AuthenTextField(
          label: AppStrings.fullName,
          hint: AppStrings.fullName,
          prefixIcon: Icons.person,
        ),
        AuthenTextField(
          label: AppStrings.email,
          hint: AppStrings.email,
          prefixIcon: Icons.email,
        ),
        AuthenTextField(
          label: AppStrings.password,
          hint: AppStrings.password,
          prefixIcon: Icons.lock,
          isPassword: true,
        ),
        AuthenTextField(
          label: AppStrings.confirmPassword,
          hint: AppStrings.confirmPassword,
          prefixIcon: Icons.lock,
          isPassword: true,
        ),
      ],
      buttonSubmit: () {},
      prefixNavigateText: AppStrings.haveAccount,
      navigateText: AppStrings.login,
      navigate: () {},
    );
  }
}
