import 'package:book_box_2/core/component/app_bar/common_app_bar_button.dart';
import 'package:book_box_2/core/extensions/extension_object.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final CommonAppBarButton? btnLeft;
  final List<CommonAppBarButton>? btnRights;

  final PreferredSizeWidget? bottom;
  final bool showUnderLine;

  const CommonAppBar({
    super.key,
    required this.title,
    this.btnLeft,
    this.btnRights,
    this.bottom,
    this.showUnderLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BookBoxColor.cwhite,
      shadowColor: BookBoxColor.cefefef,
      elevation: showUnderLine ? 0.5 : 0,
      automaticallyImplyLeading: btnLeft == null ? false : true,
      title: Text(
        title,
        style: TextStyle(
          color: BookBoxColor.c17171c,
          fontSize: 18.sp,
          fontFamily: BookBoxFontFamily.pretendardBold,
        ),
      ),
      centerTitle: true,
      leading: btnLeft,
      leadingWidth: 50.w,
      actions: btnRights,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    double appBarHeight = 48.w;
    bottom?.ifNotNull(
      (widget) => {appBarHeight += widget.preferredSize.height},
    );
    return Size.fromHeight(appBarHeight);
  }
}
