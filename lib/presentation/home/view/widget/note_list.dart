import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/note_contain.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/title_row.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/notes/view/create_note.dart';
import 'package:study_tracker_mobile/presentation/widget/loader.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: Loader(),
          );
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text('Error: ${state.errorMessageNote}'),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleRow(
              title: 'Note',
              onTap: () => context.read<HomeCubit>().viewMoreNotes(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: state.notes.isEmpty
                  ? Center(
                      child: Text(
                        'No notes available',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          state.notes.length > 3 ? 4 : state.notes.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 3 ||
                            (index == state.notes.length &&
                                state.notes.length < 3)) {
                          return _buildAddNoteButton(context, index);
                        }
                        return Padding(
                          padding: EdgeInsets.all(
                             index < 3 ? AppSize.s8 : 0,
                          ),
                          child: NoteContain(note: state.notes[index]),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildAddNoteButton(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
        right: index == 3 ? 0 : 16,
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => CreateNoteView());
        },
        child: Container(
          width: 160,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: XColors.primary,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 32,
                color: XColors.primary,
              ),
              const SizedBox(height: 8),
              Text(
                'Add Note',
                style: getSemiBoldStyle(
                  color: XColors.primary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
