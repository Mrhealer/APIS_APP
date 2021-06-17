import 'package:dio/dio.dart';

class ConfigServices {
  static Options getHeaders(
      {String token = "", String userId, String loginName, String permission}) {
    var _headers = Map<String, dynamic>();
    _headers["Content-Type"] = "application/json";
    if (token != '') {
      _headers['keytoken'] = token;
      _headers['keytokenid'] = token;
      _headers['userid'] = userId;
      _headers['loginname'] = loginName;
      _headers['quyen'] = permission;
    }

    return Options(headers: _headers);
  }

  static Map<String, String> requestHeader(
      {String token = "", String userId, String loginName, String permission}) {
    var _headers = Map<String, String>();
    _headers["Content-Type"] = "application/json";
    if (token != '') {
      _headers['keytoken'] = token;
      _headers['keytokenid'] = token;
      _headers['userid'] = userId;
      _headers['loginname'] = loginName;
      _headers['quyen'] = permission;
    }

    return _headers;
  }
}
