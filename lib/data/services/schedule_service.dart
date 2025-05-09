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
    const int maxItemsPerRequest = 4; // Maximum number of items per request
    try {
      // Retrieve token from secure storage
      final token = await _storage.read(key: 'token');
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Split schedules into batches of maxItemsPerRequest
      final batches = <List<Schedule>>[];
      for (var i = 0; i < schedules.length; i += maxItemsPerRequest) {
        final batch = schedules.sublist(
          i,
          i + maxItemsPerRequest > schedules.length ? schedules.length : i + maxItemsPerRequest,
        );
        batches.add(batch);
      }

      print('Total schedules: ${schedules.length}, Batches: ${batches.length}');

      // Send each batch sequentially
      for (var batchIndex = 0; batchIndex < batches.length; batchIndex++) {
        final batch = batches[batchIndex];
        final scheduleData = batch.map((schedule) => schedule.toJson()).toList();

        print('Sending batch ${batchIndex + 1}/${batches.length} with ${batch.length} schedules');

        final response = await _api.post(
          ApiManager.addAllSchedule,
          data: scheduleData,
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          print('Successfully added batch ${batchIndex + 1}: ${response.data}');
        } else {
          print('Failed to add batch ${batchIndex + 1}: ${response.statusCode} ${response.data}');
          print('Response headers: ${response.headers}');
          throw Exception(
            'Failed to add batch ${batchIndex + 1}: ${response.statusCode} ${response.data}',
          );
        }
      }

      print('All ${schedules.length} schedules added successfully');
    } on DioException catch (e) {
      if (e.response?.statusCode == 405) {
        print('405 Method Not Allowed: Check the HTTP method and endpoint');
        print('Requested URL: ${e.requestOptions.uri}');
        print('Method: ${e.requestOptions.method}');
        print('Response data: ${e.response?.data}');
        print('Response headers: ${e.response?.headers}');
        final allowedMethods = e.response?.headers['allow']?.join(', ');
        print('Allowed methods: $allowedMethods');
      }
      throw Exception('Failed to add schedules: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
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
