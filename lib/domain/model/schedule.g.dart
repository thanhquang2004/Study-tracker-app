// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      category: json['category'] as String,
      color: json['color'] as String,
      allDay: json['all_day'] as bool,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'all_day': instance.allDay,
      'type': instance.type,
      'status': instance.status,
      'category': instance.category,
      'color': instance.color,
    };
