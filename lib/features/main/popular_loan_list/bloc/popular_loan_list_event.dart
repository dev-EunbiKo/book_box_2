import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';

abstract class PopularLoanListEvent {
  const PopularLoanListEvent();
}

class GetPopularLoanList extends PopularLoanListEvent {
  final PMSelPopularList param;
  // 페이징을 위한 호출 여부
  final bool isMore;

  const GetPopularLoanList(this.param, this.isMore);
}
