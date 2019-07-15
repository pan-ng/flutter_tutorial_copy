


import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'subscription.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Subscription {

  @JsonKey(name: "plan_id")
  String id;

  @JsonKey(name: "id")
  String transactionId;


  Subscription(this.id, this.transactionId);

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}