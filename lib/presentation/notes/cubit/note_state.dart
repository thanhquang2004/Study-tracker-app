import 'package:equatable/equatable.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';

class NoteState extends Equatable {
  final Note? note;
  final bool isLoading;
  final String? errorMessage;

  const NoteState({
    this.note,
    this.isLoading = false,
    this.errorMessage,
  });

  NoteState copyWith({
    Note? note,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NoteState(
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [
        note,
        isLoading,
        errorMessage,
      ];
}