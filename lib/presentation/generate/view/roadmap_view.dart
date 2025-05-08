import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:study_tracker_mobile/data/helpers/date_helper.dart';
import 'package:study_tracker_mobile/data/services/schedule_service.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/stage_widget.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/custom_button.dart';

class RoadmapView extends StatelessWidget {
  final RoadmapResponse roadmap;

  const RoadmapView({super.key, required this.roadmap});

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
            Text(
              roadmap.title,
              style: getBoldStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: roadmap.stages.length,
                itemBuilder: (context, index) {
                  return StageWidget(stage: roadmap.stages[index]);
                },
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              title: "Create Schedule",
              onPressed: _createSchedule,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createSchedule() async {
    final ScheduleService scheduleService = ScheduleService();
    // Mapping the roadmap stages to schedule items
    final scheduleItems = parseRoadmapToSchedules(roadmap);
    scheduleService
        .addAllSchedules(scheduleItems)
        .timeout(const Duration(seconds: 30))
        .then(
      (value) {
        // Handle success
        Get.offAllNamed(Routes.mainRoute);
        print('Schedules created successfully!');
      },
      onError: (error) {
        // Handle error
        Get.snackbar(
          'Error',
          'Failed to create schedules',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        print('Error creating schedules: $error');
      },
    );
  }

  /// Parses RoadmapResponse to a list of Schedule objects
  List<Schedule> parseRoadmapToSchedules(
    RoadmapResponse roadmap,
  ) {
    final schedules = <Schedule>[];
    DateTime currentDate = DateTime.now();

    for (final stage in roadmap.stages) {
      for (final task in stage.tasks) {
        for (final subtask in task.subtasks) {
          final duration = parseDuration(subtask.time);
          final endDate = currentDate.add(duration);

          schedules.add(Schedule(
            id: '', // API will generate ID
            userId: roadmap.userId,
            title: subtask.name,
            description: subtask.description,
            startDate: currentDate.toIso8601String(),
            endDate: endDate.toIso8601String(),
            type: 'task',
            status: 'active',
            category: stage.name,
            roadmapId: roadmap.id,
            allDay: false,
            color: XColors.primary.toString(),
          ));

          currentDate = endDate.add(const Duration(hours: 1)); // Small gap
        }
      }
    }

    return schedules;
  }
}
