// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _containers = [
    Container(width: 100, height: 100, color: Colors.blue),
    Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(100),
      color: Colors.red,
    ),
    Container(width: 100.w, height: 100.h, color: Colors.yellow),
  ];

  Future<void> _refresh() async {
    await Future.delayed(Durations.medium1);
    debugPrint('Refresh');
    setState(() {
      _containers.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: BlocProvider를 이용하여 api 통신이 되는 페이지 구현
    return Scaffold(
      backgroundColor: BookBoxColor.cf2f3f5,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: RefreshIndicator(
              edgeOffset: 70.h,
              onRefresh: () async {
                _refresh();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(children: _containers),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
