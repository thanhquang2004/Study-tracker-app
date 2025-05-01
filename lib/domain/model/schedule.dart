import 'package:json_annotation/json_annotation.dart';
import 'package:study_tracker_mobile/data/helpers/parsing_helper.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  @JsonKey(name: 'id', fromJson: parseString)
  final String id;
  @JsonKey(name: 'title', fromJson: parseString)
  final String title;
  @JsonKey(name: 'description', fromJson: parseString)
  final String description;
  @JsonKey(name: 'start') // Changed from 'start_date' to 'start'
  final String startDate;
  @JsonKey(name: 'end')   // Changed from 'end_date' to 'end'
  final String endDate;
  @JsonKey(name: 'allDay', fromJson: parseBool)
  final bool allDay;
  @JsonKey(name: 'type', fromJson: parseString)
  final String type;
  @JsonKey(name: 'status', fromJson: parseString)
  final String status;
  @JsonKey(name: 'category', fromJson: parseString)
  final String category;
  @JsonKey(name: 'color', fromJson: parseString)
  final String color;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.status,
    required this.category,
    required this.color,
    required this.allDay,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
// Helper function to generate mock schedule data
Map<String, dynamic> _generateMockSchedule({
  required String id,
  required DateTime startDate,
  required String title,
  required String category,
  required String color,
  bool isAllDay = false,
}) {
  final endDate = startDate.add(const Duration(hours: 1));
  return {
    "id": id,
    "title": title,
    "description": "This is the description of $title.",
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "all_day": isAllDay,
    "type": "event",
    "status": "active",
    "category": category,
    "color": color,
  };
}

// Categories and their colors
final Map<String, String> _categories = {
  "work": "#FF5733",
  "study": "#33FF57",
  "meeting": "#3357FF",
  "personal": "#FF33A1",
  "health": "#33A1FF",
  "family": "#A133FF",
  "entertainment": "#FFA133",
};

// Generate mock data for a specific date
List<Map<String, dynamic>> _generateDailySchedules(DateTime date, int count) {
  final schedules = <Map<String, dynamic>>[];
  final categories = _categories.entries.toList();

  for (var i = 0; i < count; i++) {
    final category = categories[i % categories.length];
    final startTime = DateTime(
      date.year,
      date.month,
      date.day,
      8 + (i * 2) % 12, // Start from 8 AM, every 2 hours
    );

    schedules.add(_generateMockSchedule(
      id: "${date.day}-${i + 1}",
      startDate: startTime,
      title: "Schedule ${i + 1}",
      category: category.key,
      color: category.value,
      isAllDay: i % 5 == 0, // Every 5th schedule is all day
    ));
  }

  return schedules;
}

// Generate 100 mock schedules for the next 30 days
final List<Map<String, dynamic>> mockScheduleData = () {
  final schedules = <Map<String, dynamic>>[];
  final now = DateTime.now();

  for (var i = 0; i < 30; i++) {
    final date = now.add(Duration(days: i));
    final dailyCount = i % 4 + 2; // 2-5 schedules per day
    schedules.addAll(_generateDailySchedules(date, dailyCount));
  }

  return schedules;
}();
