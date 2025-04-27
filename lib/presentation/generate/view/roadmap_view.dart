import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/stage_widget.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

class RoadmapView extends StatelessWidget {
  final RoadmapResponse roadmap;

  const RoadmapView({Key? key, required this.roadmap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(roadmap.title, style: getBoldStyle( fontSize: 20),),

            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: roadmap.stages.length,
                itemBuilder: (context, index) {
                  return StageWidget(stage: roadmap.stages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



