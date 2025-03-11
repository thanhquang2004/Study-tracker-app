import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/layout/auth_layout.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_cubit.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_state.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/authen_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AuthenticateLayout(
          title: AppStrings.login,
          listTextField: [
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
          ],
          helpText: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: AppSize.s8,
            children: [
              SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Checkbox(
                  value: state.isRemember,
                  onChanged: (value) {
                    context.read<LoginCubit>().toggleRemember();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                  side: const BorderSide(
                    color: XColors.primary,
                    width: 2,
                  ),
                  activeColor: XColors.primary2,
                ),
              ),
              Text(
                AppStrings.rememberMe,
                style: TextStyle(
                  color: XColors.neutral_5,
                  fontSize: AppSize.s16,
                ),
              ),
            ],
          ),
          buttonSubmit: context.read<LoginCubit>().login,
          errorText: state.errorMessage,
          prefixNavigateText: 'Chưa có tài khoản?',
          navigateText: AppStrings.register,
          navigate: () {
            Navigator.pushNamed(context, Routes.registerRoute);
          },
        );
      },
    );
  }
}
