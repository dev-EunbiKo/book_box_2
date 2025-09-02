import 'package:book_box_2/features/main/book_detail/presentation/book_detail_page.dart';
import 'package:book_box_2/features/main/popular_loan_list/presentation/popular_loan_list_page.dart';
import 'package:book_box_2/main_navigation_page.dart';
import 'package:flutter/cupertino.dart';

/// 화면에 대한 설정 정보
class Routes {
  Routes._();

  /// Routes String Define
  static const String navigation = '/navigation';
  static const String main = '/main';
  static const String detail = '/detail';

  /// MaterialApp Routes return
  /// String에 맞는 Widget 연결
  static final routes = <String, WidgetBuilder>{
    navigation: (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as int?;
      return MainNavigationPage(selectedIndex: args ?? 0);
    },

    main: (BuildContext context) => const PopularLoanListPage(),

    detail: (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return BookDetailPage(isbn: args);
    },
  };
}
