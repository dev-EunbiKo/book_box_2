import 'package:book_box_2/core/component/app_bar/common_app_bar.dart';
import 'package:book_box_2/core/component/app_bar/common_app_bar_button.dart';
import 'package:book_box_2/core/component/custom_view/no_data_placeholder.dart';
import 'package:book_box_2/data/model/data_library/search/search_book_list_data_model.dart';
import 'package:book_box_2/data/storage/search_storage.dart';
import 'package:book_box_2/features/main/search/bloc/search_bloc.dart';
import 'package:book_box_2/features/main/search/bloc/search_event.dart';
import 'package:book_box_2/features/main/search/bloc/search_state.dart';
import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:book_box_2/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isFocus = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc()..add(const InitialEvent()),
      child: BlocConsumer<SearchBloc, SearchState>(
        // 상태가 바뀔 때 일회성으로 위젯 빌드
        listener: (context, state) {
          // navigation, snackbar, dialog 표시 등,,
        },
        // 상태에 대해 여러 번 위젯을 리빌드
        builder: (context, state) {
          final contextBloc = context.read<SearchBloc>();
          return Scaffold(
            appBar: CommonAppBar(
              title: KStringSearch.title,
              btnLeft: CommonAppBarButton(
                type: CommonAppBarButtonType.back,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: BookBoxColor.background,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 검색 TextField
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          child: _searchBox(contextBloc),
                        ),
                        // 최근 검색어
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: _recentSearches(),
                        ),

                        if (state is SearchStateSuccess)
                          Expanded(
                            child: BlocBuilder<SearchBloc, SearchState>(
                              buildWhen:
                                  (previous, current) =>
                                      current is SearchStateSuccess,
                              builder: (
                                BuildContext context,
                                SearchState state,
                              ) {
                                return _listViewBuilderCell(
                                  context,
                                  state.searchData?.response?.docs,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 검색 TextField
  Widget _searchBox(SearchBloc bloc) {
    return SizedBox(
      height: 44.h,
      child: Focus(
        child: TextField(
          controller: _textEditingController,
          style: TextStyle(
            color: BookBoxColor.black000,
            fontFamily: BookBoxFontFamily.pretendardMedium,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8.w),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 12.h, bottom: 12.h),
              child: SvgPicture.asset(BookBoxAssets.images.icSearch.path),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              borderSide: BorderSide(color: BookBoxColor.grey400, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              borderSide: BorderSide(color: BookBoxColor.indigo000, width: 1.w),
            ),
            hintText: KStringSearch.hintText,
            hintStyle: TextStyle(
              color: BookBoxColor.grey400,
              fontSize: 14.sp,
              fontFamily: BookBoxFontFamily.pretendardMedium,
            ),
            suffixIcon:
                _isFocus
                    ? IconButton(
                      onPressed: () {
                        _textEditingController.text = '';
                      },
                      iconSize: 20.w,
                      padding: EdgeInsets.only(
                        right: 0.w,
                        top: 0.h,
                        bottom: 0.h,
                      ),
                      icon: SvgPicture.asset(
                        BookBoxAssets.images.icClose.path,
                        colorFilter: const ColorFilter.mode(
                          BookBoxColor.indigo000,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                    : null,
          ),
          onSubmitted: (value) async {
            // _textEditingController.text = '';
            // api call
            // await Future.delayed(const Duration(seconds: 3));
            bloc.add(
              GetSearchListEvent(
                PMSearchBookList(
                  keyword: _textEditingController.text,
                  pageNo: 1,
                ),
                false,
              ),
            );
          },
        ),
        onFocusChange: (isFocus) {
          setState(() {
            _isFocus = isFocus;
          });
        },
      ),
    );
  }

  /// 최근 검색어 버튼
  // TODO: 버튼이 아니라 밑에 컬럼으로 보이도록 변경할 것 >> 차라리 이 부분이 추천검색어가 나오는 게 나을 듯?
  Widget _recentSearches() {
    return SizedBox(
      width: 100.w,
      height: 30.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(BookBoxColor.background),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        ),
        onPressed: () async {
          await SearchStorage.getRecentList().then((list) {
            // Navigator.of(
            //   context,
            // ).pushNamed(Routes.searchRecent, arguments: list ?? []);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: SizedBox(
                width: 16.w,
                height: 16.w,
                child: SvgPicture.asset(BookBoxAssets.images.icHistory.path),
              ),
            ),
            Text(
              KStringSearch.history,
              style: TextStyle(
                color: BookBoxColor.black000,
                fontSize: 12.sp,
                fontFamily: BookBoxFontFamily.pretendardMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _listViewBuilderCell(BuildContext context, List<SearchListData>? list) {
    if (list != null && list.isNotEmpty) {
      // final contextBloc = context.read<SearchBloc>();

      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final data = list[index];
          return Padding(
            padding: EdgeInsets.all(20),
            child: Text(data.item?.bookname ?? "error?"),
          );
        },
      );
    } else {
      return const NoDataPlaceHolder(title: KStringSearch.empty);
    }
  }
}
