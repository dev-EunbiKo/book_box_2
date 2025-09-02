// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';

abstract class SearchState {
  final DioException? error;
  final BaseDMSearchList? searchData;

  const SearchState({this.error, this.searchData});
}

/// 초기화
class SearchStateInitial extends SearchState {
  SearchStateInitial();
}

/// 조회 끝
class SearchStateSuccess extends SearchState {
  SearchStateSuccess(BaseDMSearchList searchData)
    : super(searchData: searchData);
}

/// 조회 중 에러
class SearchStateError extends SearchState {
  SearchStateError(DioException? error) : super(error: error);
}
