import 'package:book_box_2/features/main/popular_loan_list/presentation/popular_loan_list_page.dart';
import 'package:book_box_2/features/main/search/presentation/search_page.dart';
import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:book_box_2/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainNavigationPage extends StatefulWidget {
  final int selectedIndex;

  const MainNavigationPage({super.key, required this.selectedIndex});

  @override
  State<MainNavigationPage> createState() => MainNavigationPageState();
}

class MainNavigationPageState extends State<MainNavigationPage> {
  static final naviKey = GlobalKey();
  late int _selectedIndex;

  final List<Widget> _pages = [
    const MainPage(),
    SearchPage(),
    Container(color: BookBoxColor.background),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: _pages[_selectedIndex]),
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
            key: naviKey,
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },

            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedItemColor: BookBoxColor.grey300,
            unselectedFontSize: 11.sp,
            unselectedLabelStyle: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardRegular,
            ),
            selectedItemColor: BookBoxColor.indigo000,
            selectedFontSize: 11.sp,
            selectedLabelStyle: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardBold,
            ),
            items: [
              _naviBarItem(
                label: KStringNaviBar.home,
                imagePath: BookBoxAssets.images.icHome.path,
                selectedImagePath: BookBoxAssets.images.icHomeFilled.path,
              ),
              _naviBarItem(
                label: KStringNaviBar.search,
                imagePath: BookBoxAssets.images.icSearch.path,
                selectedImagePath: BookBoxAssets.images.icSearch.path,
              ),
              _naviBarItem(
                label: KStringNaviBar.myPage,
                imagePath: BookBoxAssets.images.icMypage.path,
                selectedImagePath: BookBoxAssets.images.icMypageFilled.path,
              ),
            ],
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
        width: 0.06.sw,
        height: 0.06.sw,
        fit: BoxFit.cover,
      ),
      activeIcon: SvgPicture.asset(
        selectedImagePath,
        width: 0.06.sw,
        height: 0.06.sw,
        fit: BoxFit.cover,
        colorFilter:
            imagePath == selectedImagePath
                ? const ColorFilter.mode(
                  BookBoxColor.indigo000,
                  BlendMode.srcIn,
                )
                : null,
      ),
    );
  }
}
