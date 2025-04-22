import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final String id;
  final String title;
  final String content;
  final String color;
  @JsonKey(name: 'created_at')
  final String createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}

final List<Map<String, dynamic>> mockNoteData = [
  {
    "id": "1",
    "title": "Note 1",
    "content": "This is the content of note 1.",
    "color": "#FF5733",
    "created_at": "2025-13-05T12:00:00Z"
  },
  {
    "id": "2",
    "title": "Note 2",
    "content": "This is the content of note 2.",
    "color": "#33FF57",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "3",
    "title": "Note 3",
    "content": "This is the content of note 3.",
    "color": "#3357FF",
    "created_at": "2025-15-05T12:00:00Z"
  },
  {
    "id": "4",
    "title": "Note 4",
    "content": "This is the content of note 4.",
    "color": "#FF33A1",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "5",
    "title": "Note 5",
    "content": "This is the content of note 5.",
    "color": "#FF33F6",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "6",
    "title": "Note 6",
    "content": "This is the content of note 6.",
    "color": "#FF33F6",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "7",
    "title": "Note 7",
    "content": "This is the content of note 7.",
    "color": "#FF33F6",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "8",
    "title": "Note 8",
    "content": "This is the content of note 8.",
    "color": "#FF33F6",
    "created_at": "2025-14-05T12:00:00Z"
  },
  {
    "id": "9",
    "title": "Note 9",
    "content": "This is the content of note 9.",
    "color": "#FF33F6",
    "created_at": "2025-14-05T12:00:00Z"
  }
];
