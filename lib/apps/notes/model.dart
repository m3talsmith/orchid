import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Note {
  final String? id;
  final String? title;
  final String? content;

  Note({this.id, this.title, this.content});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
