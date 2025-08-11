// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: BlocProvider를 이용하여 api 통신이 되는 페이지 구현
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Util Test'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(width: 100, height: 100, color: Colors.blue),
            Container(
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(100),
              color: Colors.red,
            ),
            Container(width: 100.w, height: 100.h, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
