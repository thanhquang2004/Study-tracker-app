import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_state.dart';
import 'package:study_tracker_mobile/presentation/dashboard/view/custom_navigation_bar.dart';
import 'package:study_tracker_mobile/presentation/home/view/home_view.dart';
import 'package:study_tracker_mobile/presentation/setting/view/setting_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      return Scaffold(
        body: IndexedStack(
          index: state.selectedIndex,
          children: [
            KeyedSubtree(
              key: const ValueKey('home'),
              child: const HomeView(),
            ),
            KeyedSubtree(
              key: const ValueKey('setting'),
              child: const SettingView(),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: state.selectedIndex,
          onTabSelected: (index) {
            context.read<DashboardCubit>().changeTab(index);
          },
        ),
      );
    });
  }
}
