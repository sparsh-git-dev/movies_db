import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movies_db/service/logger_service.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? authorization = _readAccessToken;
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $authorization';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response != null && err.response?.data != null) {
      LoggerService().logDioError(err);
    } else {
      LoggerService().logError('Network/Dio Error: ${err.message}');
    }

    handler.next(err);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    handler.next(response);
  }
}

const String _readAccessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjRkYTIwM2YwYjY2ZjQyMjkzZDc0MTRiZTYyYzY0ZSIsIm5iZiI6MTc1NjAzMjA0MS40ODEsInN1YiI6IjY4YWFlYzI5OWY0NTk0YTk3NjY3MDE5YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e7wGpaQpYUVgcapFHvGHzj9jhzStEQkdDgktc0oHQjI';
