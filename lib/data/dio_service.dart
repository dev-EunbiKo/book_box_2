import 'package:book_box_2/core/constants.dart';
import 'package:book_box_2/data/api_interceptor.dart';
import 'package:dio/dio.dart';

class DioService {
  static final Map<String, dynamic> dioData = {};
  static final DioService dioServices = DioService._internal();
  factory DioService() => dioServices;

  static Dio dio = Dio();

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: BaseUrl.dataLibraryAPIUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      queryParameters: {
        'authKey': AuthKey.dataLibraryAuthKey,
        'format': 'json',
      },
    );
    dio = Dio(options);
    dio.interceptors.add(ApiInterceptor());
  }

  Dio getDio() {
    return dio;
  }
}
