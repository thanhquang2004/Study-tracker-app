import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/data/services/schedule_service.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/generate/view/widget/stage_widget.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/custom_button.dart';
import 'package:study_tracker_mobile/presentation/widget/loader.dart';

class RoadmapView extends StatefulWidget {
  final RoadmapResponse roadmap;

  const RoadmapView({super.key, required this.roadmap});

  @override
  State<RoadmapView> createState() => _RoadmapViewState();
}

class _RoadmapViewState extends State<RoadmapView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Road Map'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.roadmap.title,
                  style: getBoldStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.roadmap.stages.length,
                    itemBuilder: (context, index) {
                      return StageWidget(stage: widget.roadmap.stages[index]);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  title: "Create Schedule",
                  onPressed: isLoading ? null : _createSchedule, // Disable button while loading
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.25 * Constants.deviceWidth),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Loader(),
                        const SizedBox(height: 16),
                        Text(
                          'Creating schedules...',
                          style: getRegularStyle(color: XColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _createSchedule() async {
    setState(() {
      isLoading = true;
    });

    final ScheduleService scheduleService = ScheduleService();
    try {
      // Mapping the roadmap stages to schedule items
      final scheduleItems = await parseRoadmapToSchedules(widget.roadmap);
      if (scheduleItems.isEmpty) {
        Get.snackbar(
          'Warning',
          'No valid schedules generated',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      print('Total schedules to send: ${scheduleItems.length}');

      // Send each schedule individually
      for (var index = 0; index < scheduleItems.length; index++) {
        final schedule = scheduleItems[index];
        print('Sending schedule ${index + 1}/${scheduleItems.length}: ${schedule.title}');
        print('Schedule JSON: ${schedule.toJson()}');

        await scheduleService.createSchedule(schedule).timeout(const Duration(seconds: 30));
        print('Successfully sent schedule ${index + 1}: ${schedule.title}');
      }

      // Handle success
      Get.offAllNamed(Routes.mainRoute);
      Get.snackbar(
        'Success',
        'All ${scheduleItems.length} schedules created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to create schedules: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('Error creating schedules: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Parses RoadmapResponse to a list of Schedule objects
  Future<List<Schedule>> parseRoadmapToSchedules(RoadmapResponse roadmap) async {
    final _storage = GetIt.instance.get<FlutterSecureStorage>();
    final userId = await _storage.read(key: 'userId') ?? '';

    final schedules = <Schedule>[];
    DateTime currentDate = DateTime.now().toUtc();

    // Validate roadmap ID and user ID
    if (roadmap.id.isEmpty || userId.isEmpty) {
      print('Error: Invalid roadmap ID or user ID');
      return schedules;
    }

    for (final stage in roadmap.stages) {
      for (final task in stage.tasks) {
        for (final subtask in task.subtasks) {
          // Parse duration safely
          final duration = parseDuration(subtask.time);
          if (duration == Duration.zero) {
            print('Warning: Invalid duration for subtask "${subtask.name}"');
            continue;
          }

          final endDate = currentDate.add(duration);

          // Create a Schedule object
          final schedule = Schedule(
            id: '',
            userId: userId,
            title: subtask.name.isNotEmpty ? subtask.name : 'Untitled Subtask',
            description:
                subtask.description.isNotEmpty ? subtask.description : 'No description provided',
            startDate: currentDate.toIso8601String(),
            endDate: endDate.toIso8601String(),
            type: 'task',
            status: 'active',
            category: stage.name.isNotEmpty ? stage.name : 'Uncategorized',
            roadmapId: roadmap.id,
            allDay: false,
            color: XColors.primary.value.toRadixString(16).substring(2), // e.g., "ff007aff"
          );

          schedules.add(schedule);
          print('Added schedule: ${schedule.title} (${schedule.startDate} - ${schedule.endDate})');

          // Update currentDate with a small gap
          currentDate = endDate.add(const Duration(hours: 1));
        }
      }
    }

    print('Total schedules generated: ${schedules.length}');
    return schedules;
  }

  /// Helper function to parse duration (e.g., "3 days", "2 weeks")
  Duration parseDuration(String time) {
    try {
      final parts = time.toLowerCase().split(' ');
      if (parts.length < 2) {
        print('Invalid duration format: "$time"');
        return Duration.zero;
      }

      final value = int.tryParse(parts[0]) ?? 0;
      final unit = parts[1];

      switch (unit) {
        case 'day':
        case 'days':
          return Duration(days: value);
        case 'week':
        case 'weeks':
          return Duration(days: value * 7);
        case 'month':
        case 'months':
          return Duration(days: value * 30);
        case 'hour':
        case 'hours':
          return Duration(hours: value);
        default:
          print('Unsupported duration unit: "$unit"');
          return Duration.zero;
      }
    } catch (e) {
      print('Error parsing duration "$time": $e');
      return Duration.zero;
    }
  }
}
