import 'dart:convert';

import 'package:apis_app/utils/auth_atils.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'config_service.dart';

enum RequestType { GET, POST, DELETE }

class BaseServices {
  Dio _dio = new Dio();
  Options _headerOption;
  final Client _client = Client();
  Map<String, String> _requestHeader;

  Future _getToken() async {
    var _token = "Bearer " + await AuthUtils.instance.getToken();

    _headerOption = ConfigServices.getHeaders(token: _token);

    _requestHeader = ConfigServices.requestHeader(token: _token);
  }

  Future<dynamic> request(String url, RequestType type,
      {dynamic data, bool useToken, bool isParameterData = false}) async {
    var response;
    if (useToken != null && useToken) {
      await _getToken();
    } else {
      _headerOption = ConfigServices.getHeaders();
    }

    try {
      switch (type) {
        case RequestType.POST:
          response = await _dio.post(url,
              data: data != null ? data : null, options: _headerOption);
          break;
        case RequestType.GET:
          if (AuthUtils.instance.getTokenLocal() != "null" &&
              AuthUtils.instance.getTokenLocal().isNotEmpty &&
              useToken != null &&
              useToken) {
            response = await _dio.get(url, options: _headerOption);
          } else {
            response = await _dio.get(url);
          }
          break;
        case RequestType.DELETE:
          response = await _dio.delete(url,
              data: data != null ? data : null, options: _headerOption);
          break;
      }
    } on DioError catch (e) {
      response = e.response;
    }
    Logger().d(response.toString());

    try {
      response = json.decode(response.toString());
    } catch (e) {
      Logger().e("json.decode error");
    }

    return response;
  }

  Future<dynamic> apiGet(String path,
      {bool isHeaders = false,
      queryParameters,
      bool isUtf8Decode = false}) async {
    var response;
    await _getToken();
    if (AuthUtils.instance.getTokenLocal() != "null" &&
        AuthUtils.instance.getTokenLocal().isNotEmpty) {
      response = (path.length > 40)
          ? await _client.get("$path", headers: _requestHeader)
          : await _client.get(Uri.http(path, queryParameters),
              headers: _requestHeader);
    } else {
      response = (path.length > 40)
          ? await _client.get("$path")
          : await _client.get(Uri.http(path, queryParameters));
    }
    Logger().d("longakak" + path);
    var statusCode = response.statusCode;
    Logger().d("longakak" + statusCode.toString());
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return json.decode(utf8.decode(response.bodyBytes));
  }
}
