import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/data/utils/convert_color.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/notes/view/note_detail.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class NoteContain extends StatelessWidget {
  final Note note;
  static const String defaultColor = '#C4D7FF'; // XColors.primary3

  const NoteContain({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = note.color.isNotEmpty
        ? hexToColor(note.color)
        : hexToColor(defaultColor);

    final textColor = XColors.neutral_1;
    final secondaryTextColor = textColor.withOpacity(0.8);

    return GestureDetector(
      onTap: () {
        Get.to(() => NoteDetailView(note: note));
      },
      child: Container(
        width: 0.42 * Constants.deviceWidth,
        height: 0.25 * Constants.deviceHeight,
        padding: const EdgeInsets.all(AppSize.s16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSize.s12),
          boxShadow: [
            BoxShadow(
              color: XColors.neutral_1.withOpacity(0.1),
              blurRadius: AppSize.s8,
              offset: const Offset(0, AppSize.s4),
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
                fontSize: AppSize.s18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSize.s8),
            Text(
              note.content,
              style: getRegularStyle(
                color: secondaryTextColor,
                fontSize: AppSize.s14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
