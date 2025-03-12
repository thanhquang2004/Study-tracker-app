import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_state.dart';
import 'package:study_tracker_mobile/presentation/dashboard/view/custom_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: state.pages,
            ),
            bottomNavigationBar: CustomNavigationBar(
              selectedIndex: state.selectedIndex,
              onTabSelected: (index) {
                context.read<DashboardCubit>().changeTab(index);
              },
            ),
            
          );
        },
      ),
    );
  }
}
