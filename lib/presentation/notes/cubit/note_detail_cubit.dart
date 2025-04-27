import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';

class NoteDetailCubit extends Cubit<Note?> {
  NoteDetailCubit(super.note);

  void updateNoteContent(String content) {
    if (state != null) {
      emit(Note(
        id: state!.id,
        title: state!.title,
        content: content,
        color: state!.color,
        createdAt: state!.createdAt,
      ));
    }
  }
}
