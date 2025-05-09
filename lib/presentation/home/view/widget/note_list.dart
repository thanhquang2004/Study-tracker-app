import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/home/view/note_view_all.dart';
import 'package:study_tracker_mobile/presentation/notes/view/note_view.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/note_contain.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/title_row.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/widget/shimmer_loading.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return ShimmerLoading(
            direction: Axis.horizontal,
            itemWidth: 0.42 * Constants.deviceWidth,
            itemHeight: 200,
            titleHeight: 40,
            itemCount: 2,
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
              onTap: () => Get.to(
                () => NoteViewAll(
                  notes: state.notes,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.notes.length > 3 ? 4 : state.notes.length + 1,
                itemBuilder: (context, index) {
                  if (index == 3 || (index == state.notes.length && state.notes.length < 3)) {
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
      padding: EdgeInsets.all(
        8,
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => NoteView());
        },
        child: Container(
          width: 0.42 * Constants.deviceWidth,
          padding: const EdgeInsets.all(AppPadding.p16),
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
