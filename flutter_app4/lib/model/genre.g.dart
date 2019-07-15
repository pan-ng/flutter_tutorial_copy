// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return Genre(
      json['name'] == null
          ? null
          : LocalizedString.fromJson(json['name'] as Map<String, dynamic>),
      json['position'] as int,
      json['poster_url'] as String,
      json['icon_url'] as String);
}

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'poster_url': instance.posterUrl,
      'icon_url': instance.iconUrl
    };
