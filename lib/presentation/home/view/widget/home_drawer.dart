import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/change_password_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/change_password_state.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: XColors.neutral_9,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildHeader(context),
            _buildMenuItems(context),
            const Spacer(),
            _buildLogoutItem(context),
            const SizedBox(height: AppSize.s16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSize.s24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [XColors.primary, XColors.primary2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'John Doe',
            style: getBoldStyle(color: Colors.white).copyWith(fontSize: AppSize.s20),
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            'john.doe@example.com',
            style: getRegularStyle(color: Colors.white.withOpacity(0.9))
                .copyWith(fontSize: AppSize.s14),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          icon: Icons.person_outline,
          title: 'Profile',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.profile);
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            Navigator.pop(context);
            _showChangePasswordDialog(context);
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, Routes.notifications);
            Get.showSnackbar(
              GetSnackBar(
                title: 'Notifications',
                message: 'This feature is not available yet.',
                duration: const Duration(seconds: 2),
                backgroundColor: XColors.neutral_7,
                borderRadius: AppSize.s20,
                padding: const EdgeInsets.all(AppSize.s16),
                margin: const EdgeInsets.symmetric(horizontal: AppSize.s32),
                snackPosition: SnackPosition.BOTTOM,
              ),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, Routes.settings);
            Get.showSnackbar(
              GetSnackBar(
                title: 'Settings',
                message: 'This feature is not available yet.',
                duration: const Duration(seconds: 2),
                backgroundColor: XColors.neutral_7,
                borderRadius: AppSize.s20,
                padding: const EdgeInsets.all(AppSize.s16),
                margin: const EdgeInsets.symmetric(horizontal: AppSize.s32),
                snackPosition: SnackPosition.BOTTOM,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: XColors.neutral_6.withOpacity(0.1),
            blurRadius: AppSize.s8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDanger ? XColors.semanticError : XColors.primary2,
          size: AppSize.s24,
        ),
        title: Text(
          title,
          style: getRegularStyle(
            color: isDanger ? XColors.semanticError : XColors.neutral_1,
          ).copyWith(fontSize: AppSize.s16),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      ),
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return _buildMenuItem(
      context,
      icon: Icons.logout,
      title: 'Logout',
      isDanger: true,
      onTap: () {
        Navigator.pop(context);
        _showLogoutDialog(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        title: Text(
          'Logout',
          style: getBoldStyle(color: XColors.neutral_1).copyWith(fontSize: AppSize.s18),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: getRegularStyle(color: XColors.neutral_3).copyWith(fontSize: AppSize.s16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: getRegularStyle(color: XColors.neutral_4).copyWith(fontSize: AppSize.s14),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AuthService().signOut().catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Logout failed: $error',
                      style: getRegularStyle(color: Colors.white),
                    ),
                    backgroundColor: XColors.semanticError,
                  ),
                );
              });
            },
            child: Text(
              'Logout',
              style: getRegularStyle(color: XColors.semanticError).copyWith(fontSize: AppSize.s14),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<ChangePasswordCubit>(
          create: (_) => ChangePasswordCubit(),
          child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) => {
              if (state.isSuccess)
                {
                  Navigator.pop(context),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đổi mật khẩu thành công'),
                      backgroundColor: Colors.green,
                    ),
                  ),
                }
            },
            builder: (context, state) {
              return AlertDialog(
                title: Text('Change Password'),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: oldPasswordController,
                        obscureText: !state.isOldPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Old Password(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<ChangePasswordCubit>().toggleOldPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: newPasswordController,
                        obscureText: !state.isNewPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'New Password(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<ChangePasswordCubit>().toggleNewPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !state.isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<ChangePasswordCubit>().toggleConfirmPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            state.errorMessage!,
                            style: getRegularStyle(
                              color: XColors.semanticError,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: getSemiBoldStyle(
                        color: XColors.semanticError,
                      ).copyWith(fontSize: AppSize.s14),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ChangePasswordCubit>().changePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
                            confirmPasswordController.text,
                          );
                    },
                    child: Text(
                      'Change Password',
                      style: getSemiBoldStyle(
                        color: XColors.semanticSuccess,
                      ).copyWith(fontSize: AppSize.s14),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
