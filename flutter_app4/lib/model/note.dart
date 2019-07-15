import 'dart:math';

import 'package:flutter_app4/utils/sql.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Note {
  @JsonKey(name: Columns.ID)
  int id;

  @JsonKey(name: NoteColumns.TITLE)
  String title;

  @JsonKey(name: NoteColumns.DESCRIPTION)
  String description;

  @JsonKey(name: NoteColumns.PRIORITY)
  int priority;

  @JsonKey(name: Columns.CREATED_AT)
  int createdAt;

  @JsonKey(name: Columns.UPDATED_AT)
  int updatedAt;

  Note(this.title,  this.createdAt, this.updatedAt, this.priority, [this.description]);

  Note.withId(this.id, this.title,   this.createdAt, this.updatedAt, this.priority, [this.description]);

  DateTime get createdDateTime => DateTime.fromMillisecondsSinceEpoch(createdAt ?? 0);

  DateTime get updatedDateTime => DateTime.fromMillisecondsSinceEpoch(updatedAt ?? 0);

  DateTime get displayDateTime {
    return DateTime.fromMillisecondsSinceEpoch(max(createdAt, updatedAt));
  }

  String get displayDateTimeText {
    var dateTime = displayDateTime;
    var now = DateTime.now();
    String format;
    if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
      format = "HH:mm";
    } else {
      format = "yyyy-MM-dd";
    }
    return DateFormat(format).format(dateTime);
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

}

class NoteColumns {
  static const NOTES = 'notes';
  static const TITLE = 'title';
  static const DESCRIPTION = 'description';
  static const COMPLETED = 'completed';
  static const TYPE = 'type';
  static const PRIORITY = 'priority';
}
