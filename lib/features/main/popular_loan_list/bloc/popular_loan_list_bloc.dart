import 'package:book_box_2/core/component/custom_view/loading_view.dart';
import 'package:book_box_2/data/data_state.dart';
import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:book_box_2/data/repository/popular_loan_list_repository.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_event.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularLoanListBloc
    extends Bloc<PopularLoanListEvent, PopularLoanListState> {
  PopularLoanListBloc() : super(const PopularLoanListLoading()) {
    on<GetPopularLoanList>(_onGetPopularLoanList);
  }

  bool isLoading = false;

  List<SelPopularListData>? popularLoanList = [];

  void _onGetPopularLoanList(
    GetPopularLoanList event,
    Emitter<PopularLoanListState> emit,
  ) async {
    if (!isLoading) {
      // 로딩 중이 아닐 때
      isLoading = !isLoading ? true : isLoading;
      await _apiCall(event, emit);
    } else {
      LoadingView.hide();
      return;
    }
  }

  Future<void> _apiCall(
    GetPopularLoanList event,
    Emitter<PopularLoanListState> emit,
  ) async {
    final popLoanRepo = PopularLoanListRepository();
    final dataState = await popLoanRepo.getPopularLoanList(
      PMSelPopularList(startDt: event.param.startDt, endDt: event.param.endDt),
    );

    if (dataState is DataSuccess) {
      final list = dataState.data?.response?.docs;

      if (list != null) {
        popularLoanList?.addAll(list);
      }

      emit(PopularLoanListDone());
      return;
    } else if (dataState is DataFailed) {
      emit(PopularLoanListError(dataState.error));
      return;
    }
  }
}
