import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app4/model/server_error.dart';
import 'package:flutter_app4/res.dart';
class AppException implements Exception {
  final String msg;
  final int code;
  final StackTrace originalStackTrace;
  AppException(this.msg, {this.code, this.originalStackTrace});


  String displayMessage({BuildContext context}) {
    return msg;
  }
}



bool showServerExceptionErrCode = false;

class JsonParseException extends AppException {
  JsonParseException(String message) : super(message);
}

class ConnectionException extends AppException {
  final IOException ioException;

  ConnectionException(this.ioException) : super("");

  @override
  String displayMessage({BuildContext context}) {
    return context == null ? "Internet Connection Error" : R.string.errorNoInternet(context);
  }

}

class ServerException extends AppException {
  final ServerError serverError;
  final String requestUrl;
  final String method;

  ServerException(this.serverError, this.requestUrl, this.method) : super("Unknown Server Error");


  @override
  String displayMessage({BuildContext context}) {
    var defaultMessage = super.displayMessage();
    return "${serverError?.msg ?? defaultMessage} ${serverError?.code ?? ""}".trimRight();
  }

}
