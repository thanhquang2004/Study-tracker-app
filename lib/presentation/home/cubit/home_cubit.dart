import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/note_service.dart';
import 'package:study_tracker_mobile/data/services/schedule_service.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteService noteService = NoteService();
  final ScheduleService scheduleService = ScheduleService();
  // Assuming you have a NoteService to fetch notes
  HomeCubit() : super(HomeState(selectedDate: DateTime.now())) {
    // Initialize with current date
    _initializeCurrentDate();
    fetchNotes();
    fetchSchedules();
  }

  void _initializeCurrentDate() {
    final now = DateTime.now();
    emit(state.copyWith(selectedDate: now));
  }

  void refreshData() {
  fetchNotes();
  fetchSchedules();
}

  Future<void> fetchNotes() async {
    emit(state.copyWith(isLoading: true));
    try {
      final notes = await noteService.fetchNotes();
      emit(state.copyWith(notes: notes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessageNote: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchSchedules() async {
    emit(state.copyWith(isLoading: true));
    try {
      final schedules =
          await scheduleService.fetchSchedulesByDate(state.selectedDate);
      emit(state.copyWith(schedules: schedules, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessageSchedule: e.toString(), isLoading: false));
    }
  }

  void selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: date, isLoading: true));
    try {
      final schedules = await scheduleService.fetchSchedulesByDate(date);
      emit(state.copyWith(schedules: schedules, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void viewMoreNotes() {
    // TODO: Implement navigation to notes screen
    print('View more notes');
  }

  void viewMoreSchedules() {
    // TODO: Implement navigation to schedules screen
    print('View more schedules');
  }
}
