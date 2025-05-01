// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: parseString(json['id']),
      title: parseString(json['title']),
      content: parseString(json['content']),
      createdAt: parseString(json['created_at']),
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt,
    };
