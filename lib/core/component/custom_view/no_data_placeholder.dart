import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:book_box_2/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({
    super.key,
    this.title,
    this.subTitle,
    this.subTitleWidget,
    this.imgPath,
  });

  final String? title;
  final String? subTitle;
  final Widget? subTitleWidget;
  final String? imgPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 202.w),
          SizedBox(
            height: 76.w,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: SvgPicture.asset(
                imgPath ?? BookBoxAssets.images.emptyIcon.path,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 6.w),
          Text(
            title ?? KStringError.noData,
            style: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardSemiBold,
              fontSize: 18.sp,
              color: BookBoxColor.c646467,
            ),
            textAlign: TextAlign.center,
          ),
          if (subTitle != null) _subTitle(subTitle ?? ''),
          if (subTitleWidget != null)
            _subTitleWidget(subTitleWidget ?? Container()),
        ],
      ),
    );
  }

  /// Text 위젯의 SubTitle
  Widget _subTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 6.w),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: BookBoxFontFamily.pretendardSemiBold,
          fontSize: 16.sp,
          color: BookBoxColor.cb7b7b9,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Widget 형태의 SubTitle
  Widget _subTitleWidget(Widget subWidget) {
    return Padding(padding: EdgeInsets.only(top: 6.w), child: subWidget);
  }
}
