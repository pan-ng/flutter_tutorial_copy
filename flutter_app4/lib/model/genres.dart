import 'package:flutter_app4/model/genre.dart';
import 'package:flutter_app4/model/subscription.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Genres` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'genres.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Genres {


  @JsonKey(name: "pop")
  Genre pop;

  @JsonKey(name: "rock")
  Genre rock;


  @JsonKey(name: "r\u0026b")
  Genre rAndb;


  @JsonKey(name: "country")
  Genre country;


  @JsonKey(name: "rap")
  Genre rap;


  @JsonKey(name: "jazz")
  Genre jazz;


  @JsonKey(name: "edm")
  Genre edm;


  @JsonKey(name: "acoustic")
  Genre acoustic;



  @JsonKey(name: "soundtrack")
  Genre soundtrack;


  @JsonKey(name: "indie")
  Genre indie;


  @JsonKey(name: "alternative")
  Genre alternative;



  @JsonKey(name: "hip hop")
  Genre hipHop;


  Genres(this.pop, this.rock, this.rAndb, this.country, this.rap, this.jazz, this.edm, this.acoustic, this.soundtrack, this.indie, this.alternative,
      this.hipHop);

  /// A necessary factory constructor for creating a new Genres instance
  /// from a map. Pass the map to the generated `_$GenresFromJson()` constructor.
  /// The constructor is named after the source class, in this case Genres.
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GenresToJson`.
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

