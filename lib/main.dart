import 'package:book_box_2/core/navigation/navigation_service.dart';
import 'package:book_box_2/core/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  // TODO: IntroType, IntroPage 추가

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (BuildContext context, Widget? _) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: Colors.pinkAccent),
          routes: Routes.routes,
          onGenerateInitialRoutes: (String initialRouteName) {
            return [
              MaterialPageRoute(
                builder:
                    (context) => MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: Routes.routes[Routes.navigation]!(context),
                    ),
              ),
            ];
          },
        );
      },
    );
  }
}
