// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:book_box_2/core/navigation/navigation_service.dart';
import 'package:book_box_2/core/navigation/routes.dart';
import 'package:book_box_2/features/main/main_home/presentation/main_page.dart';
import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:book_box_2/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Navigation extends StatefulWidget {
  final int selectedIndex;

  const Navigation({super.key, required this.selectedIndex});

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  static final naviKey = GlobalKey();
  late int selectedIndex;

  final List<Widget> _pages = [const MainPage(), Container()];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        // TODO: 위아래 틀 제외한 페이지 넣기
        child: _pages[selectedIndex],
      ),
      bottomNavigationBar: Container(
        height: 88.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: BottomNavigationBar(
            items: [
              _naviBarItem(
                label: KStringNaviBar.home,
                imagePath: BookBoxAssets.images.tabbar.naviHome.path,
                selectedImagePath: BookBoxAssets.images.tabbar.naviHomeSel.path,
              ),
              _naviBarItem(
                label: KStringNaviBar.search,
                imagePath: BookBoxAssets.images.tabbar.naviSearch.path,
                selectedImagePath: BookBoxAssets.images.tabbar.naviSearch.path,
              ),
              _naviBarItem(
                label: KStringNaviBar.myPage,
                imagePath: BookBoxAssets.images.tabbar.naviMypage.path,
                selectedImagePath:
                    BookBoxAssets.images.tabbar.naviMypageSel.path,
              ),
            ],
            onTap: (int index) {
              if (index == 0) {
                return;
              } else {
                NavigationService.push(Routes.main);
              }
              setState(() {
                selectedIndex = index;
              });
            },
            key: naviKey,
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            unselectedFontSize: 12.sp,
            unselectedLabelStyle: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardRegular,
            ),
            selectedItemColor: Theme.of(context).highlightColor,
            selectedFontSize: 12.sp,
            selectedLabelStyle: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardBold,
            ),
          ),
        ),
      ),
    );
  }

  _naviBarItem({
    required String label,
    required String imagePath,
    required String selectedImagePath,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        imagePath,
        width: 28.w,
        height: 28.h,
        fit: BoxFit.cover,
      ),
      activeIcon: SvgPicture.asset(
        selectedImagePath,
        width: 28.w,
        height: 28.h,
        fit: BoxFit.cover,
        colorFilter:
            imagePath == selectedImagePath
                ? const ColorFilter.mode(BookBoxColor.c283a7d, BlendMode.srcIn)
                : null,
      ),
    );
  }
}
