import 'package:dio/dio.dart';

class ConfigServices {
  static Options getHeaders(
      {String token = "", String userId, String loginName, String permission}) {
    var _headers = Map<String, dynamic>();
    _headers["Content-Type"] = "application/json";
    if (token != '') {
      _headers['Authorization'] = token;
    }

    return Options(headers: _headers);
  }

  static Map<String, String> requestHeader(
      {String token = "",}) {
    var _headers = Map<String, String>();
    _headers["Content-Type"] = "application/json";
    if (token != '') {
      _headers['Authorization'] = token;
    }

    return _headers;
  }
}
