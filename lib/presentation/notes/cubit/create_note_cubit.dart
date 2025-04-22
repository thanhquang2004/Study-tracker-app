import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';

class CreateNoteCubit extends Cubit<Note?> {
  CreateNoteCubit() : super(null);

  void createNote(String title, String content, String color) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      color: color,
      createdAt: DateTime.now().toIso8601String(),
    );
    emit(newNote);
  }
}
