import 'package:equatable/equatable.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';

class HomeState extends Equatable {
  final DateTime selectedDate;
  final bool isLoading;
  final String? errorMessageNote;
  final String? errorMessageSchedule;
  final String? errorMessage;
  final List<Note> notes;
  final List<Schedule> schedules;

  const HomeState({
    required this.selectedDate,
    this.isLoading = false,
    this.errorMessageNote,
    this.errorMessageSchedule,
    this.errorMessage,
    this.notes = const [],
    this.schedules = const [],
  });

  HomeState copyWith({
    DateTime? selectedDate,
    bool? isLoading,
    String? errorMessageNote,
    String? errorMessageSchedule,
    String? errorMessage,
    List<Note>? notes,
    List<Schedule>? schedules,
  }) {
    return HomeState(
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessageNote: errorMessageNote ?? this.errorMessageNote,
      errorMessageSchedule: errorMessageSchedule ?? this.errorMessageSchedule,
      errorMessage: errorMessage ?? this.errorMessage,
      notes: notes ?? this.notes,
      schedules: schedules ?? this.schedules,
    );
  }

  @override
  List<Object?> get props =>
      [selectedDate, isLoading, errorMessageNote, errorMessageSchedule,errorMessage, notes, schedules];
}
