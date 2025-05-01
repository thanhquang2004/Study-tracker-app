import 'package:json_annotation/json_annotation.dart';
import 'package:study_tracker_mobile/data/helpers/parsing_helper.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  @JsonKey(name: 'id', fromJson: parseString)
  final String id;
  
  @JsonKey(name: 'title', fromJson: parseString)
  final String title;
  
  @JsonKey(name: 'content', fromJson: parseString)
  final String content;
  
  @JsonKey(name: 'created_at', fromJson: parseString) // <-- thêm cái này
  final String createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
