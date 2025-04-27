
import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/quiz_widget.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/resource_widget.dart';

class SubtaskWidget extends StatelessWidget {
  final Subtask subtask;

  const SubtaskWidget({Key? key, required this.subtask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 16.0, bottom: 8.0),
      child: ExpansionTile(
        title: Text(subtask.name, style: const TextStyle(fontSize: 14)),
        subtitle: Text('Time: ${subtask.time}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(subtask.description),
          ),
          if (subtask.resources.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resources:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...subtask.resources
                      .map((resource) => ResourceWidget(resource: resource))
                      .toList(),
                ],
              ),
            ),
          if (subtask.quizzes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quizzes:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...subtask.quizzes
                      .map((quiz) => QuizWidget(quiz: quiz))
                      .toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}