import 'package:equatable/equatable.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';

class SchedulesState extends Equatable {
  final Schedule? schedule;
  final bool isLoading;
  final String? errorMessage;
  final bool isEditMode;
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool allDay;
  final String category;
  final String color;
  final bool isTitleValid;

  const SchedulesState({
    this.schedule,
    this.isLoading = false,
    this.errorMessage,
    this.isEditMode = false,
    this.title = '',
    this.description = '',
    this.startDate,
    this.endDate,
    this.allDay = false,
    this.category = 'study',
    this.color = '#33FF57',
    this.isTitleValid = true,
  });

  SchedulesState copyWith({
    Schedule? schedule,
    bool? isLoading,
    String? errorMessage,
    bool? isEditMode,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? allDay,
    String? category,
    String? color,
    bool? isTitleValid,
  }) {
    return SchedulesState(
      schedule: schedule ?? this.schedule,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditMode: isEditMode ?? this.isEditMode,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      allDay: allDay ?? this.allDay,
      category: category ?? this.category,
      color: color ?? this.color,
      isTitleValid: isTitleValid ?? this.isTitleValid,
    );
  }

  @override
  List<Object?> get props => [
        schedule,
        isLoading,
        errorMessage,
        isEditMode,
        title,
        description,
        startDate,
        endDate,
        allDay,
        category,
        color,
        isTitleValid,
      ];
}
