import 'dart:async';
import 'package:study_tracker_mobile/data/helpers/date_helper.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';

class ScheduleService {
  // Data fetching functions
  Future<List<Schedule>> fetchSchedulesByDate(DateTime date) async {
    final schedules = _getMockSchedules();
    return schedules.where((schedule) {
      final scheduleDate =
          formatStringToDateTime(schedule.startDate.toString());
      return scheduleDate.year == date.year &&
          scheduleDate.month == date.month &&
          scheduleDate.day == date.day;
    }).toList();
  }

  Future<List<Schedule>> fetchSchedulesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final schedules = _getMockSchedules();
    return schedules.where((schedule) {
      final scheduleStartDate =
          formatStringToDateTime(schedule.startDate.toString());
      final scheduleEndDate =
          formatStringToDateTime(schedule.endDate.toString());
      return scheduleStartDate
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          scheduleEndDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  Future<List<Schedule>> fetchAllSchedules() async {
    return _getMockSchedules();
  }

  // Helper function to get mock data
  List<Schedule> _getMockSchedules() {
    return mockScheduleData.map((data) => Schedule.fromJson(data)).toList();
  }
}
