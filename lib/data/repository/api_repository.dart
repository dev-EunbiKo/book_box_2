import 'package:book_box_2/data/data_state.dart';
import 'package:dio/dio.dart';

// TODO: 예외 구체화 구현
class ApiRepository {
  DioException createDioException(Response httpResponse) {
    return DioException(
      requestOptions: httpResponse.requestOptions,
      error: httpResponse.statusMessage,
      response: httpResponse,
      type: DioExceptionType.badResponse,
    );
  }

  DataFailed<T> checkExceptionProcess<T>(DioException exception) {
    return DataFailed(exception);
  }
}
