// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/core/component/app_bar/common_app_bar.dart';
import 'package:book_box_2/core/component/app_bar/common_app_bar_button.dart';
import 'package:book_box_2/core/component/button/scroll_to_top_floating_button.dart';
import 'package:book_box_2/core/component/custom_view/no_data_placeholder.dart';
import 'package:book_box_2/core/component/custom_view/placeholder.dart';
import 'package:book_box_2/core/extensions/extension_datetime.dart';
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
import 'package:shimmer/shimmer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController firstSC = ScrollController();
  final ScrollController secondSC = ScrollController();
  final ScrollController thirdSC = ScrollController();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularLoanListBloc>(
      create:
          (context) =>
              PopularLoanListBloc()
                ..add(
                  GetPopularLoanList(
                    PMSelPopularList(
                      pageNo: 1,
                      startDt: now.firstDateOfYear().yyyyMMdd,
                      endDt: now.lastDateOfYear().yyyyMMdd,
                    ),
                    false,
                  ),
                )
                ..add(
                  GetPopularLoanList(
                    PMSelPopularList(
                      pageNo: 1,
                      startDt:
                          now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd,
                      endDt: now.addYearsToDate(-1).lastDateOfYear().yyyyMMdd,
                    ),
                    false,
                  ),
                )
                ..add(
                  GetPopularLoanList(
                    PMSelPopularList(
                      pageNo: 1,
                      startDt:
                          now.addYearsToDate(-2).firstDateOfYear().yyyyMMdd,
                      endDt: now.addYearsToDate(-2).lastDateOfYear().yyyyMMdd,
                    ),
                    false,
                  ),
                ),

      child: Container(
        color: BookBoxColor.white000,
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: BookBoxColor.background,
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
                    indicatorColor: BookBoxColor.black100,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: BookBoxFontFamily.pretendardSemiBold,
                    ),
                    labelColor: BookBoxColor.black100,
                    tabs: [
                      SizedBox(
                        height: 36.w,
                        child: Tab(text: now.year.toString()),
                      ),
                      SizedBox(
                        height: 36.w,
                        child: Tab(
                          text: now.addYearsToDate(-1).year.toString(),
                        ),
                      ),
                      SizedBox(
                        height: 36.w,
                        child: Tab(
                          text: now.addYearsToDate(-2).year.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              body: BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                builder: (BuildContext context, PopularLoanListState state) {
                  final tc = DefaultTabController.of(context);
                  final contextRead = context.read<PopularLoanListBloc>();

                  if (state is PopularLoanListDone) {
                    // api 호출 끝
                    return TabBarView(
                      children: [
                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          buildWhen:
                              (previous, current) =>
                                  current.startDt ==
                                  now.firstDateOfYear().yyyyMMdd,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tc,
                              contextRead,
                              firstSC,
                              contextRead.thisYearList,
                            );
                          },
                        ),

                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          buildWhen:
                              (previous, current) =>
                                  current.startDt ==
                                  now
                                      .addYearsToDate(-1)
                                      .firstDateOfYear()
                                      .yyyyMMdd,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tc,
                              contextRead,
                              secondSC,
                              contextRead.lastYearList,
                            );
                          },
                        ),

                        BlocBuilder<PopularLoanListBloc, PopularLoanListState>(
                          buildWhen:
                              (previous, current) =>
                                  current.startDt ==
                                  now
                                      .addYearsToDate(-2)
                                      .firstDateOfYear()
                                      .yyyyMMdd,
                          builder: (
                            BuildContext context,
                            PopularLoanListState state,
                          ) {
                            return _listViewBuilderCell(
                              tc,
                              contextRead,
                              thirdSC,
                              contextRead.beforeLastYearList,
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is PopularLoanListLoading) {
                    // api 호출 로딩 중
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: const SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.threeLines,
                            ),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // api 에러
                    // TODO: 로딩뷰 바꾸기
                    // LoadingView.hide();
                    return NoDataPlaceHolder(title: KStringError.noData);
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
    TabController tc,
    PopularLoanListBloc bloc,
    ScrollController sc,
    List<SelPopularListData>? list,
  ) {
    if (list != null && list.isNotEmpty) {
      sc.addListener(() {
        if (!bloc.isLoading &&
            sc.position.pixels >= sc.position.maxScrollExtent - 100) {
          // TODO: 오류 발생!! -> 로딩뷰 없애기
          // LoadingView.show();
          CircularProgressIndicator();

          /// 스크롤 끝에서 추가 페이징
          _loadNextPage(bloc, tc);
        }
      });

      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));

          // 당겼을 때 탭 초기화
          if (tc.index == 0) {
            bloc.thisYearList = [];
            bloc.firstTabPage = 1;
            bloc.firstTabPageEnd = false;
          } else if (tc.index == 1) {
            bloc.lastYearList = [];
            bloc.secondTabPage = 1;
            bloc.secondTabPageEnd = false;
          } else {
            bloc.beforeLastYearList = [];
            bloc.thirdTabPage = 1;
            bloc.thirdTabPageEnd = false;
          }

          bloc.add(
            GetPopularLoanList(
              PMSelPopularList(
                pageNo: 1,
                startDt:
                    tc.index == 0
                        ? now.firstDateOfYear().yyyyMMdd
                        : tc.index == 1
                        ? now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
                        : now.addYearsToDate(-2).firstDateOfYear().yyyyMMdd,
                endDt:
                    tc.index == 0
                        ? now.lastDateOfYear().yyyyMMdd
                        : tc.index == 1
                        ? now.addYearsToDate(-1).lastDateOfYear().yyyyMMdd
                        : now.addYearsToDate(-2).lastDateOfYear().yyyyMMdd,
              ),
              false,
            ),
          );
        },
        child: ScrollToTopFloatingButton(
          scrollController: sc,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: sc,
            padding: EdgeInsets.zero,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              double verticalPadding = index == list.length - 1 ? 20.0 : 0.0;

              // api 로딩 끝, 연속 스크롤로 추가 페이징 방지
              bloc.isLoading = false;
              // TODO: 오류 발생!! -> 로딩뷰 없애기
              // LoadingView.hide();

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
      );
    } else {
      return const NoDataPlaceHolder(title: KStringPopularList.empty);
    }
  }

  _loadNextPage(PopularLoanListBloc bloc, TabController tc) {
    bloc.add(
      GetPopularLoanList(
        PMSelPopularList(
          pageNo:
              tc.index == 0
                  ? bloc.firstTabPage
                  : tc.index == 1
                  ? bloc.secondTabPage
                  : bloc.thirdTabPage,
          startDt:
              tc.index == 0
                  ? now.firstDateOfYear().yyyyMMdd
                  : tc.index == 1
                  ? now.addYearsToDate(-1).firstDateOfYear().yyyyMMdd
                  : now.addYearsToDate(-2).firstDateOfYear().yyyyMMdd,
          endDt:
              tc.index == 0
                  ? now.lastDateOfYear().yyyyMMdd
                  : tc.index == 1
                  ? now.addYearsToDate(-1).lastDateOfYear().yyyyMMdd
                  : now.addYearsToDate(-2).lastDateOfYear().yyyyMMdd,
        ),
        true,
      ),
    );
  }
}
