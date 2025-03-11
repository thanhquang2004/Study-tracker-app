import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int selectedIndex;

  const DashboardState({
    this.selectedIndex = 0,
  });

  DashboardState copyWith({
    int? selectedIndex,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}
