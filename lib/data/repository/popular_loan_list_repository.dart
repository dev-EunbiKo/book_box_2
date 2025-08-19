import 'package:book_box_2/data/api/service/main_api_service.dart';
import 'package:book_box_2/data/data_state.dart';
import 'package:book_box_2/data/dio_service.dart';
import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:book_box_2/data/repository/api_repository.dart';
import 'package:dio/dio.dart';

class PopularLoanListRepository extends ApiRepository {
  /// 인기 대출 목록
  Future<DataState<BaseDMSelPopularList>> getPopularLoanList(
    PMSelPopularList param,
  ) async {
    try {
      final apiService = MainApiService(DioService().getDio());
      final httpResponse = await apiService.selectPopularLoanList(param);
      // TODO: 분기처리 필요
      return DataSuccess(httpResponse.data);
    } on DioException catch (e) {
      return checkExceptionProcess(e);
    }
  }
}
