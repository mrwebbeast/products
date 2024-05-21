import "dart:async";
import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import "package:mrwebbeast/services/error/exceptions.dart";
import "package:mrwebbeast/services/network/http/api_service.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";

class ErrorHandler {
  static Future<APIResponse?> processAPIResponse({
    required http.BaseResponse response,
    required bool? showError,
  }) async {
    String? body;
    if (response is http.Response) {
      body = response.body;
    } else if (response is http.StreamedResponse) {
      body = await response.stream.bytesToString();
    }

    String url = Uri.parse("${response.request?.url}").toString();
    int statusCode = response.statusCode;
    String message = _getApiErrorMessage(statusCode);

    ApiException throwApIException({String? error}) {
      throw ApiException(
        url: url,
        message: error ?? message,
        statusCode: response.statusCode,
        response: body,
      );
    }

    log("API Url => $url");
    log("Status Code => $statusCode");
    log("Message :- $message");

    dynamic json;
    try {
      switch (response.statusCode) {
        case 200 || 201:
          json = jsonDecode(body ?? "");
        case 403:
          reAuth();
          throwApIException();
        default:
          throwApIException();
      }
    } catch (e) {
      rethrow;
    }
    log("body :- $json");
    return APIResponse(statusCode: statusCode, message: message, body: json);
  }

  static reAuth() async {
    String message = _getApiErrorMessage(403);
    BuildContext? context = getContext();
    showError() async {
      if (context != null) {
        showSnackBar(text: message, color: Colors.red, icon: Icons.error_outline);
      }
    }

    if (context != null) {
      showError();

      // context.read<AuthCon>().replaceToSignIn(context: context);
    }
  }

  static catchError({
    required Object error,
    required StackTrace stackTrace,
    bool? showError = true,
    bool logError = true,
    bool reportError = true,
  }) async {
    String? errorMessage;

    errorMessage = getErrorMessage(error: error);

    ///1) Logging Error ...
    if (logError) {
      // FirebaseCrashlytics.instance.recordError(errorMessage, stackTrace);
    }

    ///2) Display Error ...

    if (showError ?? true) {
      BuildContext? context = getContext();
      if (context != null) {
        showSnackBar(text: errorMessage, error: true);
      } else {
        debugPrint("App context does not found to show Error Popup");
      }
    }

    ///3) Report Error to Firebase Crashlytics...
    if (reportError) {
      // FirebaseCrashlytics.instance.log(errorMessage);
    }
  }

  /// This is Error Handling of Error...

  static String getErrorMessage({required Object error}) {
    String? message;
    String? defaultErrorMessage = "Something Went Wrong";
    if (error is ApiException) {
      message = error.message;
    } else if (error is SocketException) {
      if (error.osError?.errorCode == 7) {
        message = "No Internet connection";
      } else {
        message = error.osError?.message;
      }
    } else if (error is TimeoutException) {
      message = error.message ?? "API not responded in time";
    } else {
      message = error.toString();
    }

    return message ?? defaultErrorMessage;
  }

  // static String _getRequestStatus(int statusCode) {
  //   final status = _apiStatues[statusCode];
  //   String value = status?['name'] ?? 'Unknown error with name code $statusCode';
  //   return value;
  // }

  static String _getApiErrorMessage(int statusCode) {
    final status = _apiStatues[statusCode];
    String value = status?["message"] ?? "Unknown error with name code $statusCode";
    return value;
  }

  static final Map<int, Map<String, String>> _apiStatues = {
    200: {
      "name": "OK",
      "message": "The request completed successfully",
    },
    201: {
      "name": "Created",
      "message": "The resource was successfully created",
    },
    204: {
      "name": "NoContent",
      "message": "The request completed successfully but returned no content",
    },
    400: {
      "name": "BadRequest",
      "message": "The request was invalid",
    },
    401: {
      "name": "Unauthorized",
      "message": "Authentication failed",
    },
    403: {
      "name": "Forbidden",
      "message": "The request is not authorized",
    },
    404: {
      "name": "NotFound",
      "message": "The requested resource was not found",
    },
    405: {
      "name": "MethodNotAllowed",
      "message": "The request method is not allowed for the requested resource",
    },
    409: {
      "name": "Conflict",
      "message": "The request conflicts with the current state of the resource",
    },
    429: {
      "name": "TooManyRequests",
      "message": "Server can't handel Too Many Requests",
    },
    500: {
      "name": "InternalServerError",
      "message": "An internal server error occurred",
    },
    501: {
      "name": "NotImplemented",
      "message": "The request method is not implemented by the server",
    },
    502: {
      "name": "BadGateway",
      "message": "Bad Gateway",
    },
    503: {
      "name": "Service Unavailable",
      "message": "Service Unavailable",
    },
    504: {
      "name": "Server Timeout",
      "message": "Server Time out",
    },
    // add more error codes and messages as needed
  };
}
