import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.person,
                    title: 'Thông tin cá nhân',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.profile);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.edit,
                    title: 'Đổi mật khẩu',
                    onTap: () {
                      Navigator.pop(context);
                      _showChangePasswordDialog(context);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications,
                    title: 'Thông báo',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.notifications);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings,
                    title: 'Cài đặt ',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.settings);
                    },
                  ),
                  const Spacer(),
                  _buildMenuItem(
                    context,
                    icon: Icons.logout,
                    title: 'Đăng xuất',
                    isDanger: true,
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: AppSize.s24,
            backgroundImage: NetworkImage('https://via.placeholder.com/48'),
          ),
          const SizedBox(width: AppSize.s16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: getBoldStyle(color: Colors.black),
              ),
              Text(
                'john.doe@example.com',
                style: getRegularStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? XColors.semanticError : null,
      ),
      title: Text(
        title,
        style: isDanger
            ? getRegularStyle(color: XColors.semanticError)
            : getRegularStyle(color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: getBoldStyle(color: Colors.black)),
        content: Text(
          'Are you sure you want to logout?',
          style: getRegularStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: getRegularStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AuthService().signOut().catchError((error) {
                print('Logout error: $error');
              });
            },
            child: Text('Logout',
                style: getRegularStyle(color: XColors.semanticError)),
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
                title: Text('Đổi mật khẩu'),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: oldPasswordController,
                        obscureText: !state.isOldPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu cũ(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isOldPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<ChangePasswordCubit>()
                                  .toggleOldPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: newPasswordController,
                        obscureText: !state.isNewPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isNewPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<ChangePasswordCubit>()
                                  .toggleNewPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !state.isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu(*)',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<ChangePasswordCubit>()
                                  .toggleConfirmPasswordVisibility();
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
                      'Huỷ bỏ',
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
                    child: Text('Xác nhận'),
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
