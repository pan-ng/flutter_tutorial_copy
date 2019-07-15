// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerError _$ServerErrorFromJson(Map<String, dynamic> json) {
  return ServerError(json['error'] as String, json['err_code'] as String);
}

Map<String, dynamic> _$ServerErrorToJson(ServerError instance) =>
    <String, dynamic>{'error': instance.msg, 'err_code': instance.code};
