import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_state.dart';
import 'package:study_tracker_mobile/presentation/home/view/home_view.dart';
import 'package:study_tracker_mobile/presentation/setting/view/setting_view.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : super(
          DashboardState(
            pages: [
              HomeView(),
              SettingView(),
            ],
            selectedIndex: 0, // Đảm bảo luôn khởi tạo với index 0
          ),
        );

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // Reset state về mặc định
  void reset() {
    emit(DashboardState(
      pages: [
        HomeView(),
        SettingView(),
      ],
      selectedIndex: 0,
    ));
  }
}
