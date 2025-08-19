// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/core/component/app_bar/common_app_bar.dart';
import 'package:book_box_2/core/component/app_bar/common_app_bar_button.dart';
import 'package:book_box_2/core/component/button/scroll_to_top_floating_button.dart';
import 'package:book_box_2/core/component/custom_view/loading_view.dart';
import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_bloc.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_event.dart';
import 'package:book_box_2/features/main/popular_loan_list/bloc/popular_loan_list_state.dart';
import 'package:book_box_2/features/main/popular_loan_list/presentation/widgets/popular_loan_button_cell.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:book_box_2/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              PopularLoanListBloc()..add(
                GetPopularLoanList(
                  PMSelPopularList(startDt: '2025-08-01', endDt: '2025-08-14'),
                ),
              ),
      child: Container(
        color: BookBoxColor.cwhite,
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: BookBoxColor.cf2f3f5,
              // AppBar
              appBar: CommonAppBar(
                title: KStringPopularList.title,
                btnLeft: CommonAppBarButton(
                  type: CommonAppBarButtonType.back,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(36.w),
                  child: TabBar(
                    indicatorWeight: 2.w,
                    indicatorColor: BookBoxColor.c17171c,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: BookBoxFontFamily.pretendardSemiBold,
                    ),
                    labelColor: BookBoxColor.c161616,
                    tabs: [
                      SizedBox(height: 36.w, child: const Tab(text: '2025')),
                      SizedBox(height: 36.w, child: const Tab(text: '2024')),
                      SizedBox(height: 36.w, child: const Tab(text: '2023')),
                    ],
                  ),
                ),
              ),

              body: BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                builder: (BuildContext context, PopularLoanListState state) {
                  final tabController = DefaultTabController.of(context);
                  final contextRead = context.read<PopularLoanListBloc>();
                  // TODO: 여기서부터 구현!!
                  if (state is PopularLoanListDone) {
                    return TabBarView(
                      children: [
                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          // TODO: state에 tab에 해당하는 연도가 있어야 함
                          // buildWhen: (previous, current) => current.,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tabController,
                              contextRead,
                              scrollController,
                              contextRead.popularLoanList,
                            );
                          },
                        ),

                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          // TODO: state에 tab에 해당하는 연도가 있어야 함
                          // buildWhen: (previous, current) => current.,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tabController,
                              contextRead,
                              scrollController,
                              contextRead.popularLoanList,
                            );
                          },
                        ),

                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          // TODO: state에 tab에 해당하는 연도가 있어야 함
                          // buildWhen: (previous, current) => current.,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tabController,
                              contextRead,
                              scrollController,
                              contextRead.popularLoanList,
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is PopularLoanListLoading) {
                    // TODO: api 호출 로딩
                    return Container(color: Colors.black);
                  } else {
                    // api 에러
                    LoadingView.hide();
                    // TODO: emptyView 만들기
                    return Container(color: Colors.black);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _listViewBuilderCell(
    TabController tabController,
    PopularLoanListBloc bloc,
    ScrollController scrollController,
    List<SelPopularListData>? list,
  ) {
    if (list != null && list.isNotEmpty) {
      scrollController.addListener(() {
        if (!bloc.isLoading &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 100) {
          LoadingView.show();
          _loadNextPage(bloc, tabController);
        }
      });

      return RefreshIndicator(
        child: ScrollToTopFloatingButton(
          scrollController: scrollController,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              double verticalPadding = index == list.length - 1 ? 20.0 : 0.0;

              bloc.isLoading = false;
              LoadingView.hide();
              return Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: verticalPadding.h,
                  left: 20.w,
                  right: 20.w,
                ),
                child: PopularLoanButtonCell(data: data),
              );
            },
          ),
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));

          if (tabController.index == 0) {
            bloc.popularLoanList = [];
          }

          bloc.add(
            GetPopularLoanList(
              PMSelPopularList(startDt: '2025-01-01', endDt: '2025-08-15'),
            ),
          );
        },
      );
    } else {
      // TODO: 데이터 없을 때의 emptyView 만들기
    }
  }

  _loadNextPage(PopularLoanListBloc bloc, TabController tabController) {
    bloc.add(
      GetPopularLoanList(
        PMSelPopularList(
          startDt:
              tabController.index == 0
                  ? '2025-01-01'
                  : tabController.index == 1
                  ? '2024-01-01'
                  : '2023-01-01',
          endDt:
              tabController.index == 0
                  ? '2025-08-17'
                  : tabController.index == 1
                  ? '2024-12-31'
                  : '2023-12-31',
        ),
      ),
    );
  }
}
