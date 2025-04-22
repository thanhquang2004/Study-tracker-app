import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/notes/cubit/note_detail_cubit.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

class NoteDetailView extends StatelessWidget {
  final Note note;

  NoteDetailView({required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteDetailCubit(note),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            note.title,
            style: getBoldStyle(color: XColors.neutral_8),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit, color: XColors.neutral_8),
              onPressed: () {
                context.read<NoteDetailCubit>().updateNoteContent(note.content);
                // Implement edit functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: XColors.semanticError),
              onPressed: () {
                // Implement delete functionality
                Get.back();
              },
            ),
          ],
          backgroundColor: XColors.primary,
        ),
        body: BlocBuilder<NoteDetailCubit, Note?>(
          builder: (context, note) {
            if (note == null) return Center(child: CircularProgressIndicator());

            final contentController = TextEditingController(text: note.content);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      labelStyle: TextStyle(color: XColors.primary),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: XColors.primary),
                      ),
                    ),
                    maxLines: 5,
                    onChanged: (value) {
                      context.read<NoteDetailCubit>().updateNoteContent(value);
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: XColors.primary,
                      foregroundColor: XColors.neutral_1,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Save changes and navigate back
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
