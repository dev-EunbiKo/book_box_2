import 'package:book_box_2/features/main/main_home/presentation/main_page.dart';
import 'package:book_box_2/navigation.dart';
import 'package:flutter/cupertino.dart';

/// 화면에 대한 설정 정보
class Routes {
  Routes._();

  /// Routes String Define
  static const String navigation = '/navigation';
  static const String main = '/main';

  /// MaterialApp Routes return
  /// String에 맞는 Widget 연결
  static final routes = <String, WidgetBuilder>{
    navigation: (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as int?;
      return Navigation(selectedIndex: args ?? 0);
    },

    main: (BuildContext context) => const MainPage(),
  };
}
