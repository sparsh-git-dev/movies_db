import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

abstract class _LoggerServiceBase {
  void printLog(Object object);
  void specialLog(Object msg);
  void logInfo(Object msg);
  void logSuccess(Object msg);
  void logWarning(Object msg);
  void logError(Object msg, [StackTrace? stacktrace]);
  void logDioError(DioException error);
  void logDioRequest(RequestOptions request);
  void logDioResponse(Response response);
}

class LoggerService extends _LoggerServiceBase {
  LoggerService._internal();
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;

  @override
  void printLog(Object object) => log('$object');

  @override
  void specialLog(Object msg) => log('\x1B[36m$msg\x1B[0m');

  @override
  void logInfo(Object msg) => log('\x1B[34m$msg\x1B[0m');

  @override
  void logSuccess(Object msg) => log('\x1B[32m$msg\x1B[0m');

  @override
  void logWarning(Object msg) => log('\x1B[33m$msg\x1B[0m');

  @override
  void logError(Object msg, [StackTrace? stacktrace]) =>
      log('\x1B[31m$msg\x1B[0m', stackTrace: stacktrace);

  @override
  void logDioError(DioException error) {
    logError('--- Dio Error ---');
    if (error.response != null) {
      logError('Status Code: ${error.response!.statusCode}');
      logError('Status Message: ${error.response!.statusMessage}');
      logError('Response Data: ${jsonEncode(error.response!.data)}');
    } else {
      logError('No response received.');
    }
    logError('Error Message: ${error.message}');
    logError('Stack Trace: $error');
    logError('--- End Dio Error ---');
  }

  @override
  void logDioRequest(RequestOptions request) {
    logInfo('--- Dio Request ---');
    logInfo('URL: ${request.baseUrl}${request.path}');
    logInfo('Method: ${request.method}');
    logInfo('Headers: ${jsonEncode(request.headers)}');
    logInfo('Query Parameters: ${jsonEncode(request.queryParameters)}');
    logInfo('Body: ${jsonEncode(request.data)}');
    logInfo('--- End Dio Request ---');
  }

  @override
  void logDioResponse(Response response) {
    logSuccess('--- Dio Response ---');
    logSuccess(
      'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );
    logSuccess('Status Code: ${response.statusCode}');
    logSuccess('Response Body: ${jsonEncode(response.data)}');
    logSuccess('--- End Dio Response ---');
  }
}
