import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/setting/cubit/setting_cubit.dart';
import 'package:study_tracker_mobile/presentation/setting/cubit/setting_state.dart';
import 'package:study_tracker_mobile/presentation/setting/model/setting_model.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SettingCubit()..loadSettings(),
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return ListView(
              children: [
                buildCircleAvatar(),
                buildMenuSettings(state.settings),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildCircleAvatar() {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('Avatar tapped');
          // Handle avatar tap
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: ClipOval(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Image(
                image: AssetImage('assets/images/avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuSettings(List<SettingModel> listSettings) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300, // Light grey border color
          ),
        ),
        child: Column(
          children: listSettings.map((setting) {
            return buildMenuSettingsItem(setting: setting);
          }).toList(),
        ));
  }

  Widget buildMenuSettingsItem({
    required SettingModel setting,
  }) {
    return GestureDetector(
      onTap: setting.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          border: Border.all(color: XColors.neutral_7),
        ),
        child: Row(
          children: [
            if (setting.icon != null)
              Expanded(
                flex: 1,
                child: Icon(
                  setting.icon,
                  color: setting.colorIcon,
                ),
              ),
            Expanded(
              flex: 9,
              child: Text(
                setting.title,
                style: getSemiBoldStyle(color: XColors.neutral_1, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
