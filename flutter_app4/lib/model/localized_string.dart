
import 'package:json_annotation/json_annotation.dart';

part 'localized_string.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class LocalizedString {


  @JsonKey(name: "en")
  String en;

  @JsonKey(name: "zh")
  String zh;

  @JsonKey(name: "zt")
  String zt;

  @JsonKey(name: "ho")
  String ho;

  @JsonKey(name: "yue")
  String yue;


  @JsonKey(name: "ja")
  String ja;

  @JsonKey(name: "ko")
  String ko;

  LocalizedString(this.en, this.zh, this.zt, this.ho, this.yue, this.ja, this.ko);

  factory LocalizedString.fromJson(Map<String, dynamic> json) => _$LocalizedStringFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedStringToJson(this);


}