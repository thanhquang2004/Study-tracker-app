// models/roadmap.dart

import 'package:json_annotation/json_annotation.dart';

part 'roadmap.g.dart';

@JsonSerializable(explicitToJson: true)
class RoadmapResponse {
  @JsonKey(defaultValue: [])
  final List<Stage> stages;
  final String id;
  final String userId;
  final String title;
  @JsonKey(fromJson: _dateTimeFromIso, toJson: _dateTimeToIso)
  final DateTime createdAt;
  @JsonKey(fromJson: _dateTimeFromIso, toJson: _dateTimeToIso)
  final DateTime updatedAt;

  RoadmapResponse({
    this.stages = const [],
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoadmapResponse.fromJson(Map<String, dynamic> json) => _$RoadmapResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RoadmapResponseToJson(this);

  static DateTime _dateTimeFromIso(String date) => DateTime.parse(date);
  static String _dateTimeToIso(DateTime date) => date.toIso8601String();
}

@JsonSerializable(explicitToJson: true)
class Stage {
  final String name;
  final String timeframe;
  @JsonKey(defaultValue: [])
  final List<Task> tasks;

  Stage({
    required this.name,
    required this.timeframe,
    this.tasks = const [],
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Task {
  final String name;
  final String description;
  final String time;
  @JsonKey(defaultValue: [])
  final List<Subtask> subtasks;

  Task({
    required this.name,
    required this.description,
    required this.time,
    this.subtasks = const [],
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Subtask {
  final String name;
  final String description;
  final String time;
  @JsonKey(defaultValue: [])
  final List<Resource> resources;
  @JsonKey(defaultValue: [])
  final List<Quiz> quizzes;

  Subtask({
    required this.name,
    required this.description,
    required this.time,
    this.resources = const [],
    this.quizzes = const [],
  });

  factory Subtask.fromJson(Map<String, dynamic> json) => _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);
}

@JsonSerializable()
class Resource {
  final String content;
  @JsonKey(defaultValue: [])
  final List<String> links;

  Resource({
    this.content = '',
    this.links = const [],
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

@JsonSerializable()
class Quiz {
  final String question;
  final String answer;
  @JsonKey(defaultValue: [])
  final List<String> options;

  Quiz({
    this.question = '',
    this.answer = '',
    this.options = const [],
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
