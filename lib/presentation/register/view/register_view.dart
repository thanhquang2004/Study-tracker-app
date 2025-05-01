import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/layout/auth_layout.dart';
import 'package:study_tracker_mobile/presentation/register/cubit/register_cubit.dart';
import 'package:study_tracker_mobile/presentation/register/cubit/register_state.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/authen_dropdow.dart';
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
          height: 0.78 * Constants.deviceHeight,
          title: AppStrings.register,
          listTextField: [
            AuthenTextField(
              controller: state.usernameController,
              label: AppStrings.username,
              hint: AppStrings.username,
              prefixIcon: Icons.person,
            ),
            AuthenTextField(
              controller: state.emailController,
              label: AppStrings.email,
              hint: AppStrings.email,
              prefixIcon: Icons.email,
            ),
            AuthenTextField(
              controller: state.dobController,
              label: AppStrings.dob,
              hint: AppStrings.dob,
              prefixIcon: Icons.calendar_today,
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
            AuthenDropdown<String>(
              label: AppStrings.occupation,
              hint: AppStrings.occupation,
              items: ['Học sinh', 'Sinh viên', 'Người đi làm', 'Khác'],
              value: state.occupation,
              prefixIcon: Icons.school,
              onChanged: (val) {
                context.read<RegisterCubit>().setOccupation(val!);
                print(state.occupation);
              },
            )
          ],
          buttonSubmit: () => context.read<RegisterCubit>().register(),
          errorText: state.isError ? state.errorMessage : "",
          prefixNavigateText: AppStrings.haveAccount,
          navigateText: AppStrings.login,
          navigate: () => Get.offAndToNamed(Routes.loginRoute),
        );
      }),
    );
  }
}
