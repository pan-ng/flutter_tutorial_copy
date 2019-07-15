// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genres _$GenresFromJson(Map<String, dynamic> json) {
  return Genres(
      json['pop'] == null
          ? null
          : Genre.fromJson(json['pop'] as Map<String, dynamic>),
      json['rock'] == null
          ? null
          : Genre.fromJson(json['rock'] as Map<String, dynamic>),
      json['r&b'] == null
          ? null
          : Genre.fromJson(json['r&b'] as Map<String, dynamic>),
      json['country'] == null
          ? null
          : Genre.fromJson(json['country'] as Map<String, dynamic>),
      json['rap'] == null
          ? null
          : Genre.fromJson(json['rap'] as Map<String, dynamic>),
      json['jazz'] == null
          ? null
          : Genre.fromJson(json['jazz'] as Map<String, dynamic>),
      json['edm'] == null
          ? null
          : Genre.fromJson(json['edm'] as Map<String, dynamic>),
      json['acoustic'] == null
          ? null
          : Genre.fromJson(json['acoustic'] as Map<String, dynamic>),
      json['soundtrack'] == null
          ? null
          : Genre.fromJson(json['soundtrack'] as Map<String, dynamic>),
      json['indie'] == null
          ? null
          : Genre.fromJson(json['indie'] as Map<String, dynamic>),
      json['alternative'] == null
          ? null
          : Genre.fromJson(json['alternative'] as Map<String, dynamic>),
      json['hip hop'] == null
          ? null
          : Genre.fromJson(json['hip hop'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'pop': instance.pop,
      'rock': instance.rock,
      'r&b': instance.rAndb,
      'country': instance.country,
      'rap': instance.rap,
      'jazz': instance.jazz,
      'edm': instance.edm,
      'acoustic': instance.acoustic,
      'soundtrack': instance.soundtrack,
      'indie': instance.indie,
      'alternative': instance.alternative,
      'hip hop': instance.hipHop
    };
