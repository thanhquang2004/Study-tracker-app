import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/schedule_service.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/schedules/cubit/schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  final ScheduleService _scheduleService = ScheduleService();

  SchedulesCubit(Schedule? schedule)
      : super(SchedulesState(
          schedule: schedule,
          startDate: schedule != null ? DateTime.parse(schedule.startDate) : DateTime.now(),
          endDate: schedule != null
              ? DateTime.parse(schedule.endDate)
              : DateTime.now().add(const Duration(hours: 1)),
          isEditMode: schedule == null,
          title: schedule?.title ?? '',
          description: schedule?.description ?? '',
          allDay: schedule?.allDay ?? false,
          category: schedule?.category ?? 'study',
          color: schedule?.color ?? '#33FF57',
        ));

  void initializeForm() {
    if (state.schedule != null) {
      emit(state.copyWith(
        title: state.schedule!.title,
        description: state.schedule!.description,
        startDate: DateTime.parse(state.schedule!.startDate),
        endDate: DateTime.parse(state.schedule!.endDate),
        allDay: state.schedule!.allDay,
        category: state.schedule!.category,
        color: state.schedule!.color,
        isEditMode: false,
      ));
    } else {
      emit(state.copyWith(isEditMode: true));
    }
  }

  void updateTitle(String title) {
    emit(state.copyWith(
      title: title,
      isTitleValid: title.isNotEmpty,
    ));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateStartDate(DateTime date) {
    DateTime newStartDate = DateTime(
      date.year,
      date.month,
      date.day,
      state.startDate!.hour,
      state.startDate!.minute,
    );
    DateTime newEndDate = state.endDate!;
    if (newEndDate.isBefore(newStartDate)) {
      newEndDate = newStartDate.add(const Duration(hours: 1));
    }
    emit(state.copyWith(startDate: newStartDate, endDate: newEndDate));
  }

  void updateEndDate(DateTime date) {
    DateTime newEndDate = DateTime(
      date.year,
      date.month,
      date.day,
      state.endDate!.hour,
      state.endDate!.minute,
    );
    if (newEndDate.isBefore(state.startDate!)) {
      newEndDate = state.startDate!.add(const Duration(hours: 1));
    }
    emit(state.copyWith(endDate: newEndDate));
  }

  void updateStartTime(TimeOfDay time) {
    DateTime newStartDate = DateTime(
      state.startDate!.year,
      state.startDate!.month,
      state.startDate!.day,
      time.hour,
      time.minute,
    );
    DateTime newEndDate = state.endDate!;
    if (newEndDate.year == newStartDate.year &&
        newEndDate.month == newStartDate.month &&
        newEndDate.day == newStartDate.day &&
        newEndDate.isBefore(newStartDate)) {
      newEndDate = newStartDate.add(const Duration(hours: 1));
    }
    emit(state.copyWith(startDate: newStartDate, endDate: newEndDate));
  }

  void updateEndTime(TimeOfDay time) {
    DateTime newEndDate = DateTime(
      state.endDate!.year,
      state.endDate!.month,
      state.endDate!.day,
      time.hour,
      time.minute,
    );
    if (newEndDate.year == state.startDate!.year &&
        newEndDate.month == state.startDate!.month &&
        newEndDate.day == state.startDate!.day &&
        newEndDate.isBefore(state.startDate!)) {
      newEndDate = state.startDate!.add(const Duration(hours: 1));
    }
    emit(state.copyWith(endDate: newEndDate));
  }

  void toggleAllDay(bool value) {
    emit(state.copyWith(allDay: value));
  }

  void selectCategory(String category, String color) {
    emit(state.copyWith(category: category, color: color));
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  Future<void> saveSchedule(String userId, String roadmapId) async {
    if (state.title.isEmpty) {
      emit(state.copyWith(isTitleValid: false));
      return;
    }

    if (state.schedule == null) {
      await createSchedule(
        title: state.title,
        description: state.description,
        startDate: state.startDate!,
        endDate: state.endDate!,
        allDay: state.allDay,
        category: state.category,
        color: state.color,
        userId: userId,
        roadmapId: roadmapId,
      );
    } else {
      await updateSchedule(
        id: state.schedule!.id!,
        title: state.title,
        description: state.description,
        startDate: state.startDate,
        endDate: state.endDate,
        allDay: state.allDay,
        category: state.category,
        color: state.color,
      );
    }
  }

  Future<void> createSchedule({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool allDay,
    required String category,
    required String color,
    required String userId,
    required String roadmapId,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));
      final schedule = Schedule(
        title: title,
        description: description,
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
        allDay: allDay,
        type: 'event',
        status: 'active',
        category: category,
        color: color,
        userId: userId,
        roadmapId: roadmapId,
      );
      await _scheduleService.createSchedule(schedule);
      emit(state.copyWith(
        schedule: schedule,
        isLoading: false,
        isEditMode: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateSchedule({
    required String id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? allDay,
    String? category,
    String? color,
    String? type,
    String? status,
  }) async {
    if (state.schedule == null) {
      emit(state.copyWith(errorMessage: 'No schedule to update'));
      return;
    }
    try {
      emit(state.copyWith(isLoading: true));
      final currentSchedule = state.schedule!;
      final updatedSchedule = Schedule(
        id: id,
        title: title ?? currentSchedule.title,
        description: description ?? currentSchedule.description,
        startDate: startDate?.toIso8601String() ?? currentSchedule.startDate,
        endDate: endDate?.toIso8601String() ?? currentSchedule.endDate,
        allDay: allDay ?? currentSchedule.allDay,
        type: type ?? currentSchedule.type,
        status: status ?? currentSchedule.status,
        category: category ?? currentSchedule.category,
        color: color ?? currentSchedule.color,
        userId: currentSchedule.userId,
        roadmapId: currentSchedule.roadmapId,
      );
      await _scheduleService.updateSchedule(updatedSchedule);
      emit(state.copyWith(
        schedule: updatedSchedule,
        isLoading: false,
        isEditMode: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteSchedule(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _scheduleService.deleteSchedule(id);
      emit(const SchedulesState(
        startDate: null,
        endDate: null,
        isLoading: false,
      )); // Reset to initial state
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
