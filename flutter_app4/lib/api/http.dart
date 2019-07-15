import 'dart:io';

import 'package:flutter_app4/model/genres.dart';
import 'package:flutter_app4/model/server_error.dart';
import 'package:flutter_app4/utils/json.dart';
import 'package:http/http.dart';

import '../exception.dart';

class BackendClient extends BaseClient {
  Client _inner;

  static BackendClient _instance;

  factory BackendClient() {
    _instance = _instance == null ? BackendClient._() : _instance;
    return _instance;
  }

  BackendClient._() {
    HttpClient().connectionTimeout = Duration(seconds: 8);
    _inner = Client();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers["User-Agent"] = "aaaaa";
    // check request.method and add content-type if needed
    return _inner.send(request);
  }

  Future<Response> postJsonObject(String url, Map<String, dynamic> jsonObjectMap) {
    var postBody = Json.toJsonString(jsonObjectMap);
    return _inner.post(url, body: postBody);
  }
}

class API {
  BackendClient client;

  API() {
    client = BackendClient();
  }

  Future<K> _httpCall<K>(
      Future<Response> responseFuture, K Function(Map<String, dynamic>) toObject) async {
    Response response;
    final startTimeMs = DateTime.now().millisecondsSinceEpoch;
    try {
      response = await responseFuture;
    } on IOException catch (e) {
      // catches any IO error
      throw ConnectionException(e);
    }

    debugLines(startTimeMs, response.request, response).forEach((line) {
      print(line);
    });
    // got the response
    final statusCode = response.statusCode;
    if (200 <= statusCode && statusCode <= 205) {
      // If server returns an OK response, parse the JSON
      return toObject(Json.toJsonMap(response.body));
    } else {
      // If that response was not OK (but still an response from server)
      var serverException = _toServerException(response.request, response);
      // could do server error checking here and start reauth???
      throw serverException;
    }
  }

  /// convert the error response from server as an [ServerException] object
  Exception _toServerException(Request request, Response response) {
    try {
      return ServerException(ServerError.fromJson(Json.toJsonMap(response.body)),
          request.url.toString(), request.method);
    } catch (e) {
      return JsonParseException("Unable to parse error response");
    }
  }

  List<String> debugLines(int startTimeMs, Request request, Response response) {
    var lines = List<String>();
    int tookMs = DateTime.now().millisecondsSinceEpoch - startTimeMs;

    lines.add("[$tookMs ms][${request.method}]${request.url.toString()}");
    String responseBody = response.body;
    if (responseBody != null) {
      lines.add(responseBody);
    }
    return lines;
  }
}



class GenresAPI extends API {
  Future<Genres> getGenres() async {
    return _httpCall(client.get("https://api.popsical.tv/v1/genres.json"),
        (Map<String, dynamic> json) {
      return Genres.fromJson(json);
    });
  }

  Future<Genres> postGenres() async {
    final postBody = Map<String, dynamic>()..putIfAbsent("aa", () => "a");
    return _httpCall(client.postJsonObject("https://api.popsical.tv/v1/genres.json", postBody),
        (Map<String, dynamic> json) => Genres.fromJson(json));
  }
}
