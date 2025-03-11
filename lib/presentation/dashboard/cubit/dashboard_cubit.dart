import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
