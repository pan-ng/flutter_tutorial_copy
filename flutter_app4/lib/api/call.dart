



import 'package:flutter_app4/exception.dart';

class Result<K> {
  final K successObject;
  final AppException exception;

  Result([this.successObject, this.exception]);
}


