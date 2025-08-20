// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';

abstract class PopularLoanListState {
  final BaseDMSelPopularList? popularLoanData;
  final DioException? error;
  final String? startDt;

  const PopularLoanListState({this.popularLoanData, this.error, this.startDt});
}

class PopularLoanListLoading extends PopularLoanListState {
  const PopularLoanListLoading() : super();
}

class PopularLoanListDone extends PopularLoanListState {
  PopularLoanListDone(String? startDt) : super(startDt: startDt);
}

class PopularLoanListError extends PopularLoanListState {
  const PopularLoanListError(DioException? error) : super(error: error);
}
