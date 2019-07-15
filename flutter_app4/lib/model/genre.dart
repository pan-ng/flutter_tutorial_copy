import 'package:flutter_app4/model/localized_string.dart';
import 'package:flutter_app4/model/subscription.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Genre` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'genre.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Genre {

  @JsonKey(name: "name")
  LocalizedString name;

  @JsonKey(name: "position")
  int position;

  @JsonKey(name: "poster_url")
  String posterUrl;

  @JsonKey(name: "icon_url")
  String iconUrl;

  Genre(this.name, this.position, this.posterUrl, this.iconUrl);

  /// A necessary factory constructor for creating a new Genre instance
  /// from a map. Pass the map to the generated `_$GenreFromJson()` constructor.
  /// The constructor is named after the source class, in this case Genre.
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GenreToJson`.
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

