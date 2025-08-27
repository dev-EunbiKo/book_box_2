import 'package:book_box_2/data/api/service/main_api_service.dart';
import 'package:book_box_2/data/data_state.dart';
import 'package:book_box_2/data/dio_service.dart';
import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';
import 'package:book_box_2/data/repository/api_repository.dart';
import 'package:dio/dio.dart';

class SearchRepository extends ApiRepository {
  Future<DataState<BaseDMSearchList>> getSearchList(
    PMSearchBookList param,
  ) async {
    try {
      final apiService = MainApiService(DioService().getDio());
      final httpResponse = await apiService.searchBookList(param);
      return DataSuccess(httpResponse.data);
    } on DioException catch (e) {
      return checkExceptionProcess(e);
    }
  }
}
