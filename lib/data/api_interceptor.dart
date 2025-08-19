import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[REQ] [HEADER] ${options.headers}');
    debugPrint('[REQ] [BODY] ${options.data}');
    debugPrint('[REQ] [${options.method}] ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );
    debugPrint('[RES] [DATA] ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}',
    );
    debugPrint(
      '[ERR] [${err.response?.statusCode}] ${err.response?.statusMessage}',
    );
    super.onError(err, handler);
  }
}
