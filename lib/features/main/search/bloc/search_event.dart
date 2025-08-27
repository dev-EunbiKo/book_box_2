// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';

abstract class SearchEvent {
  const SearchEvent();
}

// 검색 필터 추후 고도화
// class SearchGetFilterEvent extends SearchEvent {
//   const SearchGetFilterEvent();
// }

class InitialEvent extends SearchEvent {
  const InitialEvent();
}

class GetSearchListEvent extends SearchEvent {
  // final dynamic selectedCtg;
  final PMSearchBookList param;
  final bool isMore;

  const GetSearchListEvent(this.param, this.isMore);
}
