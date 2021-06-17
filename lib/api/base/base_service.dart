import 'dart:convert';

import 'package:apis_app/utils/auth_atils.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'config_service.dart';

enum RequestType { GET, POST, DELETE }

class BaseServices {
  Dio _dio = new Dio();
  Options _headerOption;
  final Client _client = Client();
  Map<String, String> _requestHeader;

  Future _getToken() async {
    var _token = await AuthUtils.instance.getToken();
    var _userId = await AuthUtils.instance.getUserId();

    _headerOption =
        ConfigServices.getHeaders(token: _token, userId: _userId.toString());
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

    //* handling error and status code
    try {
      response = json.decode(response.toString());
    } catch (e) {
      Logger().e("json.decode error");
    }

    return isParameterData
        ? json.decode("{ \"Data\" " + ":" + response.body + "}")
        : response;
  }

  Future<dynamic> apiGet(String path,
      {bool isHeaders = false,
      queryParameters,
      bool isUtf8Decode = false}) async {
    var response;
    if (isHeaders) {
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
    } else {
      response = (path.length > 40)
          ? await _client.get("$path")
          : await _client.get(Uri.http(path, queryParameters));
    }
    Logger().d(path);

    var statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return isUtf8Decode
        ? json.decode(utf8.decode(response.bodyBytes))
        : json.decode("{ \"Data\" " + ":" + response.body + "}");
  }

  Future<dynamic> apiGetForWriteForm(String path,
      {bool isHeaders = false,
      queryParameters,
      bool isUtf8Decode = false}) async {
    var response;
    if (isHeaders) {
      _getToken();
      if (AuthUtils.instance.getTokenLocal() != "null" &&
          AuthUtils.instance.getTokenLocal().isNotEmpty) {
        response = (path.length > 40)
            ? await _client.get("$path", headers: _requestHeader)
            : await _client.get(Uri.http(path, queryParameters),
                headers: _requestHeader);
      } else {
        Logger().d("1111");

        response = (path.length > 40)
            ? await _client.get("$path")
            : await _client.get(Uri.http(path, queryParameters));
      }
    } else {
      response = (path.length > 40)
          ? await _client.get("$path")
          : await _client.get(Uri.http(path, queryParameters));
    }

    var statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      return null;
      throw new Exception("Error while fetching data");
    }

    return isUtf8Decode
        ? json.decode(utf8.decode(response.bodyBytes))
        : json.decode(response.body);
  }

  Future<dynamic> apiGetNotConvert(String path,
      {bool isHeaders = false,
      queryParameters,
      bool isUtf8Decode = false}) async {
    var response;
    if (isHeaders) {
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
    } else {
      response = (path.length > 40)
          ? await _client.get("$path")
          : await _client.get(Uri.http(path, queryParameters));
    }

    var statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return isUtf8Decode
        ? json.decode(utf8.decode(response.bodyBytes))
        : json.decode(response.body);
  }

  Future<dynamic> apiPost(String path,
      {bool isHeaders = false,
      body,
      encoding,
      bool isUtf8Decode = false}) async {
    if (isHeaders) {
      await _getToken();
    }
    Logger().d(body);

    var _body = json.encode(body);
    var response;
    if (AuthUtils.instance.getTokenLocal() != "null" &&
        AuthUtils.instance.getTokenLocal().isNotEmpty) {
      response = await _client.post(path,
          headers: _requestHeader, body: _body, encoding: encoding);
    } else {
      response = await _client.post(path, body: _body, encoding: encoding);
    }
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return isUtf8Decode
        ? json.decode(utf8.decode(response.bodyBytes))
        : json.decode("{ \"Data\" " + ":" + response.body + "}");
  }

  Future<dynamic> apiPostCheckData(String path,
      {bool isHeaders = false,
      body,
      encoding,
      bool isUtf8Decode = false}) async {
    if (isHeaders) {
      await _getToken();
    }

    Logger().d(path);

    var request = http.Request('POST', Uri.parse(path));
    request.body = '''"$body"''';
    request.headers.addAll(_requestHeader);

    http.StreamedResponse response = await request.send();
    Logger().d("Lomgkaka " + response.statusCode.toString());
    var responseData;
    if (response.statusCode == 200) {
      responseData = await response.stream.bytesToString();
    } else {
      responseData = response.reasonPhrase;
    }
    Logger().d(responseData.toString());
    return json.decode("{ \"Data\" " + ":" + responseData + "}");
  }
}
