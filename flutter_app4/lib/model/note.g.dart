// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
      json['title'] as String,
      json['created_at'] as int,
      json['updated_at'] as int,
      json['priority'] as int,
      json['description'] as String)
    ..id = json['id'] as int;
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt
    };
