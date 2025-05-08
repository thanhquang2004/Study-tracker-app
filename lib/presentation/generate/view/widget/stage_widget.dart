import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/task_widget.dart';

class StageWidget extends StatelessWidget {
  final Stage stage;

  const StageWidget({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text( 
          stage.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('Duration: ${stage.timeframe}'),
        children: stage.tasks
            .map((task) => TaskWidget(task: task))
            .toList(),
      ),
    );
  }
}