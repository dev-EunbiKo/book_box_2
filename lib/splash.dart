import 'package:book_box_2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initialization();
}

/// Firebase 등 초기화에 필요한 작업
Future<void> initialization() async {
  await appCheck();
}

/// 루팅, 업데이트 체크 후 runApp
Future<void> appCheck() async {
  FlutterNativeSplash.remove();
  return runApp(const MyApp());
}
