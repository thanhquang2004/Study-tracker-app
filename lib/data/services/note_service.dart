import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class NoteService {
  final _storage = GetIt.instance<FlutterSecureStorage>();
  final _api = GetIt.instance<ApiService>();

Future<List<Note>> fetchNotes() async {
  final userId = await _storage.read(key: 'userId');

  try {
    final response = await _api.get(ApiManager.getMyNotes(userId!));
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is List) {
        return data.map((note) => Note.fromJson(note as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Expected a List but got ${data.runtimeType}');
      }
    } else {
      throw Exception('Failed to fetch notes');
    }
  } on DioException catch (e) {
    print("Error fetching notes: $e");
    throw Exception("Failed to fetch notes: $e");
  }
}

  Future<void> createNote(String title, String content) async {
    final userId = await _storage.read(key: 'userId');

    try {
      // Simulate creating a note in a database or API
      final response = await _api.post(ApiManager.createNote, data: {
        'title': title,
        'content': content,
        'userId': userId,
      });
      if (response.statusCode != 200) {
        throw ("Failed to create note: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw ("Failed to create note: $e");
    }
  }

  Future<Note> updateNote(String id, String title, String content) async {
    final userId = await _storage.read(key: 'userId');

    try {
      // Simulate updating a note in a database or API
      final response = await _api.put(ApiManager.updateNote(id), data: {
        'title': title,
        'content': content,
        'userId': userId,
      });
      if (response.statusCode == 200) {
        return Note.fromJson(response.data['result']);
      } else {
        throw ("Failed to update note: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw ("Failed to update note: $e");
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      // Simulate deleting a note in a database or API
      final response = await _api.delete(ApiManager.deleteNote(id));
      if (response.statusCode != 200) {
        throw ("Failed to delete note: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw ("Failed to delete note: $e");
    }
  }
}
