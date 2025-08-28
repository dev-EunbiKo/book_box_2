import 'package:book_box_2/core/extensions/extension_datetime.dart';
import 'package:book_box_2/data/data_state.dart';
import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:book_box_2/data/repository/popular_loan_list_repository.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_event.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularLoanListBloc
    extends Bloc<PopularLoanListEvent, PopularLoanListState> {
  // api 로딩 여부
  bool isLoading = false;

  int firstTabPage = 1;
  int secondTabPage = 1;
  int thirdTabPage = 1;
  bool firstTabPageEnd = false;
  bool secondTabPageEnd = false;
  bool thirdTabPageEnd = false;

  List<SelPopularListData>? thisYearList = [];
  List<SelPopularListData>? lastYearList = [];
  List<SelPopularListData>? beforeLastYearList = [];

  final now = DateTime.now();

  // 초기 상태값 지정 & 이벤트 핸들러 등록
  PopularLoanListBloc() : super(const PopularLoanListLoading()) {
    on<GetPopularLoanList>(_onGetPopularLoanList);
  }

  void _onGetPopularLoanList(
    GetPopularLoanList event,
    Emitter<PopularLoanListState> emit,
  ) async {
    final isEnd =
        event.param.startDt == now.firstDateOfYear().yyyyMMdd
            ? firstTabPageEnd
            : event.param.startDt ==
                now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
            ? secondTabPageEnd
            : thirdTabPageEnd;
    if (!isEnd && (!event.isMore || !isLoading)) {
      // 페이징이 끝이 아니고, 페이징을 위한 호출이 아니거나 로딩 중이 아닐 때
      isLoading = !isLoading ? true : isLoading;
      await _apiCall(event, emit);
    } else {
      return;
    }
  }

  Future<void> _apiCall(
    GetPopularLoanList event,
    Emitter<PopularLoanListState> emit,
  ) async {
    final popLoanRepo = PopularLoanListRepository();
    final dataState = await popLoanRepo.getPopularLoanList(
      PMSelPopularList(
        startDt: event.param.startDt,
        endDt: event.param.endDt,
        pageNo: event.param.pageNo,
      ),
    );

    if (dataState is DataSuccess) {
      final list = dataState.data?.response?.docs;

      if (list != null) {
        // 15개씩 호출 -> 15개 미만이면 페이지 끝이라고 판단
        if (list.length < 15) {
          event.param.startDt == now.firstDateOfYear().yyyyMMdd
              ? firstTabPageEnd = true
              : event.param.startDt ==
                  now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
              ? secondTabPageEnd = true
              : thirdTabPageEnd = true;
        } else {
          event.param.startDt == now.firstDateOfYear().yyyyMMdd
              ? firstTabPage++
              : event.param.startDt ==
                  now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
              ? secondTabPage++
              : thirdTabPage++;
          event.param.startDt == now.firstDateOfYear().yyyyMMdd
              ? firstTabPageEnd = false
              : event.param.startDt ==
                  now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
              ? secondTabPageEnd = false
              : thirdTabPageEnd = false;
        }

        event.param.startDt == now.firstDateOfYear().yyyyMMdd
            ? thisYearList?.addAll(list)
            : event.param.startDt ==
                now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
            ? lastYearList?.addAll(list)
            : beforeLastYearList?.addAll(list);
      }

      emit(PopularLoanListDone(event.param.startDt));
      return;
    } else if (dataState is DataFailed) {
      emit(PopularLoanListError(dataState.error));
      return;
    }
  }
}
