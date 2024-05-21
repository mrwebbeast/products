class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class ApiException implements Exception {
  final String? url;
  final int? statusCode;
  final String message;
  final String? response;
  final Object? error;
  final StackTrace? stackTrace;

  ApiException({
    this.url,
    this.statusCode,
    required this.message,
    this.response,
    this.error,
    this.stackTrace,
  });
}
