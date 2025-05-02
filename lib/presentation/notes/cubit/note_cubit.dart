import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:study_tracker_mobile/data/services/note_service.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/notes/cubit/note_state.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';

class NoteCubit extends Cubit<NoteState>{
  final NoteState initialState = const NoteState(
    note: null,
    isLoading: false,
    errorMessage: null,
  );
  final NoteService _noteService = NoteService();
  NoteCubit(NoteState initialState) : super(initialState);

  Future<void> createNote(String title, String content) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _noteService.createNote(title, content);
      emit(state.copyWith(isLoading: false));
      Get.offAllNamed(Routes.mainRoute);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
  Future<void> updateNoteContent(String title,String content) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _noteService.updateNote(state.note!.id, title, content);
      emit(state.copyWith(isLoading: false));
      Get.offAllNamed(Routes.mainRoute);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> deleteNote(String id) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _noteService.deleteNote(id);
            emit(state.copyWith(isLoading: false));
            
      Get.offAllNamed(Routes.mainRoute);
      Get.snackbar(
        'Delete Note',
        'Note deleted successfully',
        backgroundColor: XColors.neutral_9,
        colorText: XColors.semanticSuccess,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}