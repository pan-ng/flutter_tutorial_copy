
import 'package:json_annotation/json_annotation.dart';

part 'server_error.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class ServerError {

  @JsonKey(name: "error")
  String msg;

  @JsonKey(name: "err_code")
  String code;


  ServerError(this.msg, this.code);

  factory ServerError.fromJson(Map<String, dynamic> json) => _$ServerErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorToJson(this);


}