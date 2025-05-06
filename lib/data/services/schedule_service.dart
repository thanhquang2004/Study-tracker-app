import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class ScheduleService {
  final _api = GetIt.instance.get<ApiService>();
  final _storage = GetIt.instance.get<FlutterSecureStorage>();
  // Data fetching functions
  Future<List<Schedule>> fetchSchedulesByDate(DateTime date) async {
    try {
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

  Future<void> addAllSchedules(List<Schedule> schedules) async {
    try {
      final response = await _api.post(
        ApiManager.addAllSchedule,
        data: schedules.map((schedule) => schedule.toJson()).toList(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add schedules: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error adding schedules: ${e.message}');
      throw Exception('Failed to add schedules: $e');
    }
  }

  Future<void> createSchedule(Schedule schedule) async {
    try {
      final response = await _api.post(
        ApiManager.createSchedule,
        data: schedule.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add schedule: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error adding schedule: ${e.message}');
      throw Exception('Failed to add schedule: $e');
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      final response = await _api.delete(
        ApiManager.scheduleById(scheduleId),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete schedule: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error deleting schedule: ${e.message}');
      throw Exception('Failed to delete schedule: $e');
    }
  }

  Future<void> updateSchedule(Schedule schedule) async {
    try {
      final response = await _api.put(
        ApiManager.scheduleById(schedule.id!),
        data: schedule.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update schedule: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error updating schedule: ${e.message}');
      throw Exception('Failed to update schedule: $e');
    }
  }
}
