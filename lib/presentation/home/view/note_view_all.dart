import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/note_contain.dart';

class NoteViewAll extends StatelessWidget {
  final List<Note> notes;
  const NoteViewAll({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
        backgroundColor: XColors.primary,
        foregroundColor: XColors.neutral_8,
        elevation: 0, // Loại bỏ bóng của AppBar để giao diện phẳng hơn
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'No notes available',
                style: TextStyle(
                  fontSize: 18,
                  color: XColors.neutral_5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cột
                  crossAxisSpacing: 16, // Khoảng cách ngang giữa các item
                  mainAxisSpacing: 16, // Khoảng cách dọc giữa các item
                  childAspectRatio: 0.75, // Tỷ lệ chiều rộng/chiều cao của mỗi item
                ),
                itemBuilder: (context, index) {
                  return NoteContain(note: notes[index]);
                },
                itemCount: notes.length,
                physics: const BouncingScrollPhysics(), // Hiệu ứng cuộn mượt
              ),
            ),
    );
  }
}