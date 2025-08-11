// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final int selectedIndex;

  const Navigation({super.key, required this.selectedIndex});

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  static final naviKey = GlobalKey();
  late int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Column(
          children: [
            Text('Here is'), Text('Navigation'),
            // TODO: 위아래 틀 제외한 페이지 넣기
          ],
        ),
      ),
      // TODO: bottomNavigationBar 구현
    );
  }
}
