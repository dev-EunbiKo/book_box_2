import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'main_api_service.g.dart';

@RestApi()
abstract class MainApiService {
  factory MainApiService(Dio dio, {String baseUrl}) = _MainApiService;

  @GET('/loanItemSrch')
  Future<HttpResponse<BaseDMSelPopularList>> selectPopularLoanList(
    @Queries() PMSelPopularList param,
  );
}
