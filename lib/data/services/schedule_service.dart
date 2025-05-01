import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/data/helpers/date_helper.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class ScheduleService {
  final _api = GetIt.instance.get<ApiService>();
  final _storage = GetIt.instance.get<FlutterSecureStorage>();
  // Data fetching functions
  Future<List<Schedule>> fetchSchedulesByDate(DateTime date) async {
    try{
    final response = await _api.get(
      ApiManager.getScheduleByDate,
      queryParameters: {
        'userId': await _storage.read(key: 'userId'),
        'date': date.toIso8601String(),
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['result'];
      return data.map((schedule) => Schedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Failed to load schedules: ${response.statusCode}');
    }
    } on DioException catch (e) {
      print('Error fetching schedules: ${e.message}');
      throw Exception('Failed to load schedules: $e');
    }
    
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
