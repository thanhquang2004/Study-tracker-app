import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/notes/view/note_detail.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class NoteContain extends StatelessWidget {
  final Note note;

  const NoteContain({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = XColors.neutral_1;
    final secondaryTextColor = textColor.withOpacity(0.7);

    return GestureDetector(
      onTap: () {
        Get.to(() => NoteDetailView(note: note));
      },
      child: Container(
        width: 0.42 * Constants.deviceWidth,
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: XColors.neutral_8,
          borderRadius: BorderRadius.circular(AppSize.s16),
          boxShadow:  [
            BoxShadow(
            color: XColors.neutral_5.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: getBoldStyle(
                color: textColor,
                fontSize: AppSize.s16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSize.s12),
            Expanded(
              child: Text(
                note.content,
                style: getRegularStyle(
                  color: secondaryTextColor,
                  fontSize: AppSize.s14,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
