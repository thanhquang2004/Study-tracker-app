// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: parseString(json['id']),
      title: parseString(json['title']),
      description: parseString(json['description']),
      startDate: json['start'] as String,
      endDate: json['end'] as String,
      type: parseString(json['type']),
      status: parseString(json['status']),
      category: parseString(json['category']),
      color: parseString(json['color']),
      allDay: parseBool(json['allDay']),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start': instance.startDate,
      'end': instance.endDate,
      'allDay': instance.allDay,
      'type': instance.type,
      'status': instance.status,
      'category': instance.category,
      'color': instance.color,
    };
