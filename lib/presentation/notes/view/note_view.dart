import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/notes/cubit/note_cubit.dart';
import 'package:study_tracker_mobile/presentation/notes/cubit/note_state.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/confirm_dialog.dart';
import 'package:study_tracker_mobile/presentation/widget/custom_button.dart';
import 'package:study_tracker_mobile/presentation/widget/loading_dialog.dart';

class NoteView extends StatelessWidget {
  final Note? note;
  const NoteView({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(NoteState(note: note)),
      child: NoteContent(note: note),
    );
  }
}

class NoteContent extends StatefulWidget {
  final Note? note;
  const NoteContent({super.key, this.note});

  @override
  State<NoteContent> createState() => _NoteContentState();
}

class _NoteContentState extends State<NoteContent> {
  bool isEditMode = false;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        backgroundColor: XColors.primary,
        iconTheme: const IconThemeData(color: XColors.neutral_9),
        actions: widget.note != null
            ? [
                IconButton(
                  icon: const Icon(Icons.edit, color: XColors.neutral_9),
                  onPressed: () => setState(() => isEditMode = !isEditMode),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: XColors.semanticError),
                  onPressed: () => Get.dialog(
                    ConfirmAlert(
                      content: 'Are you sure you want to delete this note?',
                      onConfirm: () {
                        context.read<NoteCubit>().deleteNote(widget.note!.id);
                        Get.back(); // Close the dialog
                      },
                      title: 'Delete',
                    ),
                  ),
                ),
              ]
            : null, 
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state.isLoading) return const LoadingDialog();
          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: XColors.semanticError),
              ),
            );
          }
          return state.note != null
              ? isEditMode
                  ? _buildEditNoteForm(context, state.note!)
                  : _buildNoteView(state.note!)
              : _buildCreateNoteForm(context);
        },
      ),
    );
  }

  Widget _buildNoteView(Note note) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: XColors.neutral_1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            note.content,
            style: const TextStyle(color: XColors.neutral_2),
          ),
        ],
      ),
    );
  }

  Widget _buildEditNoteForm(BuildContext context, Note note) {
    _titleController.text = note.title;
    _contentController.text = note.content;
    return _buildNoteForm(
      buttonText: 'Save',
      onPressed: () => context.read<NoteCubit>().updateNoteContent(
            _titleController.text,
            _contentController.text,
          ),
    );
  }

  Widget _buildCreateNoteForm(BuildContext context) {
    return _buildNoteForm(
      buttonText: 'Create',
      onPressed: () => context.read<NoteCubit>().createNote(
            _titleController.text,
            _contentController.text,
          ),
    );
  }

  Widget _buildNoteForm({
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: XColors.neutral_3),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: XColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contentController,
            minLines: 6,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'Content',
              labelStyle: TextStyle(color: XColors.neutral_3),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: XColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(title: buttonText, onPressed: onPressed),
        ],
      ),
    );
  }
}