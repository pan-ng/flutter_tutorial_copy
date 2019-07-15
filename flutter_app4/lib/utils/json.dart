import 'dart:convert';


class Json {
  static Map<String, dynamic> toJsonMap(String jsonString) {
    return jsonDecode(jsonString);
  }

  static String toJsonString(Object obj) {
    return jsonEncode(obj);
  }

}



