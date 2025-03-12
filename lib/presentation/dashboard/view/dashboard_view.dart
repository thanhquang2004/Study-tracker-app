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
  late DashboardCubit _dashboardCubit;

  @override
  void initState() {
    super.initState();
    // Kiểm tra nếu chưa có DashboardCubit thì khởi tạo
    _dashboardCubit = Get.isRegistered<DashboardCubit>()
        ? Get.find<DashboardCubit>()
        : Get.put(DashboardCubit());

    _dashboardCubit.reset(); // Đảm bảo về trang HomeView khi khởi tạo
  }

  @override
  void dispose() {
    // Xóa Cubit khi Dashboard bị hủy
    if (Get.isRegistered<DashboardCubit>()) {
      Get.delete<DashboardCubit>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: _dashboardCubit,
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: state.pages,
          ),
          bottomNavigationBar: CustomNavigationBar(
            selectedIndex: state.selectedIndex,
            onTabSelected: (index) {
              _dashboardCubit.changeTab(index);
            },
          ),
        );
      },
    );
  }
}
