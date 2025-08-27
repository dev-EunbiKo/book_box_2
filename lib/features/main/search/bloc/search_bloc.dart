import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';
import 'package:book_box_2/features/main/search/bloc/search_event.dart';
import 'package:book_box_2/features/main/search/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<SearchListData>? list = [];

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
  ) async {}
}
