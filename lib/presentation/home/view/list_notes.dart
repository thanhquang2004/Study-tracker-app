import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/note_contain.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

class ListNotes extends StatelessWidget {
  final List<Note> notes;
  const ListNotes({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: XColors.primary,
        foregroundColor: XColors.neutral_8,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteContain(note: notes[index]);
        },
      ),
    );
  }
}
