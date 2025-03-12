import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/layout/auth_layout.dart';
import 'package:study_tracker_mobile/presentation/register/cubit/register_cubit.dart';
import 'package:study_tracker_mobile/presentation/register/cubit/register_state.dart';
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
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child:
          BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
        return AuthenticateLayout(
          title: AppStrings.register,
          listTextField: [
            AuthenTextField(
              controller: state.fullNameController,
              label: AppStrings.fullName,
              hint: AppStrings.fullName,
              prefixIcon: Icons.person,
            ),
            AuthenTextField(
              controller: state.emailController,
              label: AppStrings.email,
              hint: AppStrings.email,
              prefixIcon: Icons.email,
            ),
            AuthenTextField(
              controller: state.passwordController,
              label: AppStrings.password,
              hint: AppStrings.password,
              prefixIcon: Icons.lock,
              isPassword: true,
            ),
            AuthenTextField(
              controller: state.confirmPasswordController,
              label: AppStrings.confirmPassword,
              hint: AppStrings.confirmPassword,
              prefixIcon: Icons.lock,
              isPassword: true,
            ),
          ],
          buttonSubmit: () => context.read<RegisterCubit>().register(),
          errorText: state.isError ? state.errorMessage : "",
          prefixNavigateText: AppStrings.haveAccount,
          navigateText: AppStrings.login,
          navigate: () => Navigator.of(context).pop(),
        );
      }),
    );
  }
}
