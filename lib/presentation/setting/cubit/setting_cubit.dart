import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/setting/cubit/setting_state.dart';
import 'package:study_tracker_mobile/presentation/setting/model/setting_model.dart';
import 'package:study_tracker_mobile/presentation/widget/confirm_dialog.dart';
import 'package:study_tracker_mobile/presentation/widget/loading_dialog.dart';

class SettingCubit extends Cubit<SettingState> {
  final AuthService _authService = AuthService();
  SettingCubit() : super(const SettingState());

  void loadSettings() async {
    final settings = [
      SettingModel(
        title: AppStrings.information,
        icon: Icons.person_outline,
        onTap: () {
          print("Information");
        },
      ),
      SettingModel(
        title: AppStrings.logout,
        icon: Icons.logout,
        colorIcon: XColors.semanticError,
        onTap: () => logout(),
      ),
    ];

    emit(state.copyWith(settings: settings));
  }

  Future<void> logout() async {
    Get.dialog(ConfirmAlert(
      title: AppStrings.logout,
      content: AppStrings.confirmLogout,
      onConfirm: () async {
        Get.dialog(LoadingDialog());
        await _authService.signOut();
        Get.offNamedUntil(Routes.loginRoute, (route) => true);
      },
      emergency: true,
    ));
  }
}
