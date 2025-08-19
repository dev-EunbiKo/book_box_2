// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularLoanButtonCell extends StatelessWidget {
  final SelPopularListData? data;

  const PopularLoanButtonCell({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: BookBoxColor.c00000000,
      onTap: () {
        // TODO: 페이지 렌딩 구현
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 22.w,
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: SvgPicture.asset(
                data?.item?.bookImageURL ?? '',
                fit: BoxFit.contain,
              ),
            ),
          ),

          Column(
            children: [
              Text(
                data?.item?.bookname ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: BookBoxColor.c283a7d,
                  fontFamily: BookBoxFontFamily.pretendardMedium,
                ),
              ),
              Text(
                data?.item?.authors ?? '',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: BookBoxColor.c00000000,
                  fontFamily: BookBoxFontFamily.pretendardLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
