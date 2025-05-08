
import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/subtask_widget.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: ExpansionTile(
        title: Text(task.name, style: const TextStyle(fontSize: 16)),
        subtitle: Text('Time: ${task.time}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(task.description),
          ),
          ...task.subtasks
              .map((subtask) => SubtaskWidget(subtask: subtask))
              ,
        ],
      ),
    );
  }
}
