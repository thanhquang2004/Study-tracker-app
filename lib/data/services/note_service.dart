import 'package:study_tracker_mobile/domain/model/note.dart';

class NoteService {
  Future<List<Note>> fetchNotes() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching notes from a database or API
      final response = mockNoteData;
      if (response.isNotEmpty) {
        return response.map((note) => Note.fromJson(note)).toList();
      } else {
        throw Exception("No notes found");
      }
    } catch (e) {
      throw Exception("Failed to fetch notes: $e");
    }
  }

  Future<Note> createNote(Note note) async {
    try {
      // Simulate creating a note in a database or API
      mockNoteData.add(note.toJson());
      return note; // Return the note that was added
    } catch (e) {
      throw Exception("Failed to create note: $e");
    }
  }

  Future<Note> updateNote(String id, Note note) async {
    try {
      // Simulate updating a note in a database or API
      final index = mockNoteData.indexWhere((note) => note['id'] == id);
      if (index != -1) {
        mockNoteData[index] = note.toJson();
        return Note.fromJson(mockNoteData[index]);
      } else {
        throw Exception("Note not found");
      }
    } catch (e) {
      throw Exception("Failed to update note: $e");
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      // Simulate deleting a note in a database or API
      mockNoteData.removeWhere((note) => note['id'] == id);
    } catch (e) {
      throw Exception("Failed to delete note: $e");
    }
  }
}
