import 'package:book_box_2/data/data_state.dart';
import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';
import 'package:book_box_2/data/repository/search_repository.dart';
import 'package:book_box_2/features/main/search/bloc/search_event.dart';
import 'package:book_box_2/features/main/search/bloc/search_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  bool isLoading = false; // 로딩 여부
  List<SearchListData>? searchList = []; // api 결과

  int pageNo = 1; // 페이지
  bool pageEnd = false; // 마지막 페이지 여부

  SearchBloc() : super(SearchStateInitial()) {
    on<InitialEvent>(_searchInitial);
    on<GetSearchListEvent>(_onGetSearchList);
  }

  // TODO: 초기 상태에서 최근검색어 값 넘겨주기
  void _searchInitial(SearchEvent event, Emitter<SearchState> emit) {
    emit(SearchStateInitial());
  }

  void _onGetSearchList(
    GetSearchListEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (!pageEnd && (!event.isMore || !isLoading)) {
      await _apiCall(event, emit);
    } else {
      return;
    }
  }

  Future<void> _apiCall(
    GetSearchListEvent event,
    Emitter<SearchState> emit,
  ) async {
    debugPrint('search api');
    final searchRepo = SearchRepository();
    final dataState = await searchRepo.getSearchList(
      PMSearchBookList(
        keyword: event.param.keyword,
        pageNo: event.param.pageNo,
      ),
    );

    if (dataState is DataSuccess) {
      final response = dataState.data;

      if (response?.response?.docs != null) {
        final list = response!.response!.docs!;
        debugPrint('search api response');
        pageEnd = list.length < 15 ? true : false;
        pageNo = list.length < 15 ? pageNo : pageNo++;
        searchList?.addAll(list);
      }
      emit(SearchStateSuccess(response!));
      return;
    } else if (dataState is DataFailed) {
      emit(SearchStateError(dataState.error));
      return;
    }
  }
}
