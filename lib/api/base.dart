/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: base
*/

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:salepro/api/client.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAPI<T extends Mappable> {
  final String basePath;

  BaseAPI(this.basePath);

  Future<Uri> _buildUri(
      {String? endpoint, Map<String, dynamic>? queryParams}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;

    String url = "$apiUrl/$basePath${endpoint != null ? '/$endpoint' : ''}";

    if (queryParams != null && queryParams.isNotEmpty) {
      String queryString = queryParams.entries
          .map((entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
          .join('&');
      url = '$url?$queryString';
    }

    return Uri.parse(url);
  }

  T fromJson(Map<String, dynamic> json);

  Future<Data<T>> GET(
      {String? token,
      int? count,
      int perPage = 20,
      bool paginate = true,
      Map<String, String>? searchParams}) async {
    final headers = buildHeaders(token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final queryParams = <String, dynamic>{};
    if (paginate) {
      queryParams['page'] = count ?? 1;
      queryParams['per_page'] = perPage;
    }
    if (searchParams != null && searchParams.isNotEmpty) {
      queryParams.addAll(searchParams);
    }
    
    final response = await http.get(
      await _buildUri(queryParams: queryParams),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res is Map && res['data'] != null) {
        return Data<T>.fromJson(res, fromJson);
      } else {
        return Data<T>.fromJson(
            {"require_pagination": false, "data": res}, fromJson);
      }
    } else {
      throw Exception('Error al cargar datos: ${response.body}');
    }
  }

  Future<Data<T>> POSTFORDATA(
      {required Mappable data,
      String? token,
      int? count,
      int perPage = 20,
      bool paginate = true}) async {
    http.Response response;
    final headers = buildHeaders(token, isJson: true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    if (count != null && paginate) {
      response = await http.post(
        await _buildUri(
          queryParams: {
            "per_page": perPage,
            "page": count,
            "paginate": paginate,
            "token": spToken,
          },
        ),
        headers: headers,
        body: jsonEncode(data.toFormData()),
      );
    } else {
      response = await http.post(
        await _buildUri(
          queryParams: {
            "paginate": paginate,
            "token": spToken,
          },
        ),
        headers: headers,
        body: jsonEncode(data.toFormData()),
      );
    }
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);

      if (res is Map && res['data'] != null) {
        if (res['invalid_token'] != null && res['invalid_token']) {
          prefs.clear();
        }

        return Data<T>.fromJson(res, fromJson);
      } else {
        return Data<T>.fromJson(
          {
            "require_pagination": false,
            "data": res,
          },
          fromJson,
        );
      }
    } else {
      return Data<T>.fromJson({
        "require_pagination": false,
        "data": [],
      }, fromJson);
    }
  }

  Future<T?> SINGLE({
    String? token,
  }) async {
    final headers = buildHeaders(token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";
    final http.Response response = await http.get(
      await _buildUri(
        queryParams: {
          "token": spToken,
        },
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res is Map && res['data'] != null) {
        if (res['invalid_token'] != null && res['invalid_token']) {
          prefs.clear();
        }
        return fromJson(res['data']);
      } else {
        return fromJson(res);
      }
    } else {
      return null;
    }
  }

  Future<T?> POSTFORSINGLEDATA(
      {required Mappable data,
      String? token,
      int? count,
      int perPage = 20,
      bool paginate = true}) async {
    http.Response response;
    final headers = buildHeaders(token, isJson: true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    if (count != null && paginate) {
      response = await http.post(
        await _buildUri(
          queryParams: {
            "per_page": perPage,
            "page": count,
            "paginate": paginate,
            "token": spToken,
          },
        ),
        headers: headers,
        body: jsonEncode(data.toFormData()),
      );
    } else {
      response = await http.post(
        await _buildUri(
          queryParams: {
            "paginate": paginate,
            "token": spToken,
          },
        ),
        headers: headers,
        body: jsonEncode(data.toFormData()),
      );
    }

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res is Map && res['data'] != null) {
        if (res['invalid_token'] != null && res['invalid_token']) {
          prefs.clear();
        }

        return fromJson(res['data']);
      } else {
        return fromJson(res);
      }
    } else {
      return null;
    }
  }

  Future<Message> POST({
    required Mappable data,
    String? token,
    Map<String, String>? fileData,
  }) async {
    http.Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    if (fileData != null) {
      response = await _uploadFile(
        data: _convertToStringMap(data.toFormData()),
        fileData: fileData,
        token: token,
      );
    } else {
      final headers = buildHeaders(token, isJson: true);
      response = await http.post(
        await _buildUri(
          queryParams: {
            "token": spToken,
          },
        ),
        headers: headers,
        body: jsonEncode(data.toFormData()),
      );
    }
    return _parseMessageResponse(response, prefs);
  }

  Future<Message> PUT({
    required int id,
    required Mappable data,
    String? token,
  }) async {
    final headers = buildHeaders(token, isJson: true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    final response = await http.put(
      await _buildUri(
        endpoint: id.toString(),
        queryParams: {
          "token": spToken,
        },
      ),
      headers: headers,
      body: jsonEncode(data.toFormData()),
    );

    return _parseMessageResponse(response, prefs);
  }

  Future<Message> DELETE({
    required int id,
    String? token,
  }) async {
    final headers = buildHeaders(token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    final response = await http.delete(
      await _buildUri(
        endpoint: id.toString(),
        queryParams: {
          "token": spToken,
        },
      ),
      headers: headers,
    );
    return _parseMessageResponse(response, prefs);
  }

  Map<String, String> buildHeaders(String? token, {bool isJson = false}) {
    final headers = <String, String>{};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (isJson) {
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = 'application/json';
    }
    return headers;
  }

  Future<http.Response> _uploadFile({
    required Map<String, String> data,
    required Map<String, String> fileData,
    String? token,
  }) async {
    var imageFile = File(fileData['path']!);
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    var request = http.MultipartRequest(
        'POST',
        await _buildUri(queryParams: {
          "token": spToken,
        }));
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    var multipartFile = http.MultipartFile(
      fileData['key']!,
      stream,
      length,
      filename: fileData['path']!.split('/').last,
    );

    request.fields.addAll(data);
    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var responseBody = await streamedResponse.stream.bytesToString();
    return http.Response(responseBody, streamedResponse.statusCode);
  }

  Map<String, String> _convertToStringMap(Map<String, dynamic> map) {
    return map.map((key, value) => MapEntry(key, value?.toString() ?? ''));
  }

  Message _parseMessageResponse(http.Response response, prefs) {
    try {
      final body = jsonDecode(response.body);
      if (body['invalid_token'] != null && body['invalid_token']) {
        prefs.clear();
      }
      return Message.fromJson(body);
    } catch (e) {
      return Message(
        invalidToken: false,
        success: false,
        message: "An error occurred while parsing the response.",
      );
    }
  }
}
