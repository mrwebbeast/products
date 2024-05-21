import "dart:core";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

import "package:mrwebbeast/core/config/app_config.dart";

import "package:mrwebbeast/services/error/exception_handler.dart";

String decodeQueryParameter({required Map<String, String>? body}) {
  String formattedData = "";
  List<String>? bodyList = [];

  if (body != null) {
    body.forEach((key, value) {
      bodyList.add("&$key=$value");
    });
    formattedData = bodyList.join("").replaceFirst("&", "?");
  }

  if (formattedData.isNotEmpty) {
    debugPrint("Query Params are :- $formattedData");
  }
  return formattedData;
}

///Seconds
Map<String, String> defaultHeaders() {
  return {};
}

class APIResponse {
  final int? statusCode;
  final String? message;
  final dynamic body;

  APIResponse({this.statusCode, this.message, this.body});
}

class ApiService {
  static const Duration timeOutDuration = Duration(seconds: 45);

  ///1) Get Request...

  static Future<APIResponse?> get({
    required String endPoint,
    String? baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool? showError,
  }) async {
    String url = (baseUrl ?? ApiConfig.baseUrl) + endPoint;
    var uri = Uri.parse("$url${decodeQueryParameter(body: queryParameters)}");

    APIResponse? apiResponse;
    try {
      var response = await http.get(uri, headers: headers ?? defaultHeaders()).timeout(timeOutDuration);

      ///Process API Response...
      apiResponse = await ErrorHandler.processAPIResponse(response: response, showError: showError);
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: showError);
    }

    return apiResponse;
  }

  ///2) POST Request...

  static Future<APIResponse?> post({
    required String endPoint,
    String? baseUrl,
    Map<String, String>? headers,
    Object? body,
    bool? showError,
  }) async {
    String url = (baseUrl ?? ApiConfig.baseUrl) + endPoint;
    var uri = Uri.parse(url);
    APIResponse? apiResponse;
    try {
      final response =
          await http.post(uri, headers: headers ?? defaultHeaders(), body: body).timeout(timeOutDuration);

      ///Process API Response...
      apiResponse = await ErrorHandler.processAPIResponse(response: response, showError: showError);
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: showError);
    }
    return apiResponse;
  }

  ///3) PUT Request...

  Future<APIResponse?> put({
    required String endPoint,
    String? baseUrl,
    Map<String, String>? headers,
    Object? body,
    bool? showError,
  }) async {
    String url = (baseUrl ?? ApiConfig.baseUrl) + endPoint;
    var uri = Uri.parse(url);
    APIResponse? apiResponse;
    try {
      final response = body == null
          ? await http.put(uri, headers: headers ?? defaultHeaders())
          : await http.put(uri, headers: headers ?? defaultHeaders(), body: body).timeout(timeOutDuration);

      ///Process API Response...
      apiResponse = await ErrorHandler.processAPIResponse(response: response, showError: showError);
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: showError);
    }
    return apiResponse;
  }

  ///4) Patch Request...

  static Future<APIResponse?> patch({
    required String endPoint,
    String? baseUrl,
    Map<String, String>? headers,
    Object? body,
    bool? showError,
  }) async {
    String url = (baseUrl ?? ApiConfig.baseUrl) + endPoint;
    var uri = Uri.parse(url);
    APIResponse? apiResponse;
    try {
      final response =
          await http.patch(uri, headers: headers ?? defaultHeaders(), body: body).timeout(timeOutDuration);

      ///Process API Response...
      apiResponse = await ErrorHandler.processAPIResponse(response: response, showError: showError);
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: showError);
    }
    return apiResponse;
  }

  ///5) MultiPart  Request...

  static Future<APIResponse?> multiPart({
    required String endPoint,
    required Map<String, String> body,
    String? baseUrl,
    Map<String, String>? headers,
    List<MultiPartData>? multipartFile,
    bool? showError,
  }) async {
    String url = (baseUrl ?? ApiConfig.baseUrl) + endPoint;
    var uri = Uri.parse(url);
    APIResponse? apiResponse;
    try {
      var request = http.MultipartRequest("POST", uri);
      request.fields.addAll(body);
      if (multipartFile != null) {
        for (final element in multipartFile) {
          debugPrint("Multipart... Field ${element.field}: FilePath ${element.filePath}");
          if (element.field != null && element.filePath != null) {
            request.files.add(await http.MultipartFile.fromPath("${element.field}", "${element.filePath}"));
          }
        }
      }
      request.headers.addAll(headers ?? defaultHeaders());
      http.StreamedResponse response = await request.send();

      ///Process API Response...
      apiResponse = await ErrorHandler.processAPIResponse(response: response, showError: showError);
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: showError);
    }
    return apiResponse;
  }
}

class MultiPartData {
  MultiPartData({
    required this.field,
    required this.filePath,
  });

  String? field;
  String? filePath;

  factory MultiPartData.fromJson(Map<String, dynamic> json) => MultiPartData(
        field: json["field"],
        filePath: json["filePath"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "filePath": filePath,
      };
}
