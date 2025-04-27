// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapResponse _$RoadmapResponseFromJson(Map<String, dynamic> json) =>
    RoadmapResponse(
      stages: (json['stages'] as List<dynamic>?)
              ?.map((e) => Stage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      createdAt: RoadmapResponse._dateTimeFromIso(json['createdAt'] as String),
      updatedAt: RoadmapResponse._dateTimeFromIso(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RoadmapResponseToJson(RoadmapResponse instance) =>
    <String, dynamic>{
      'stages': instance.stages.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'createdAt': RoadmapResponse._dateTimeToIso(instance.createdAt),
      'updatedAt': RoadmapResponse._dateTimeToIso(instance.updatedAt),
    };

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      name: json['name'] as String,
      timeframe: json['timeframe'] as String,
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'name': instance.name,
      'timeframe': instance.timeframe,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      name: json['name'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'time': instance.time,
      'subtasks': instance.subtasks.map((e) => e.toJson()).toList(),
    };

Subtask _$SubtaskFromJson(Map<String, dynamic> json) => Subtask(
      name: json['name'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      resources: (json['resources'] as List<dynamic>?)
              ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      quizzes: (json['quizzes'] as List<dynamic>?)
              ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SubtaskToJson(Subtask instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'time': instance.time,
      'resources': instance.resources.map((e) => e.toJson()).toList(),
      'quizzes': instance.quizzes.map((e) => e.toJson()).toList(),
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      content: json['content'] as String? ?? '',
      links:
          (json['links'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'content': instance.content,
      'links': instance.links,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'options': instance.options,
    };
