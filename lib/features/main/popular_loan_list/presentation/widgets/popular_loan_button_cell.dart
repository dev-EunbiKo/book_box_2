// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/core/utils.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:book_box_2/data/model/data_library/popular_loan/select_popular_loan_list_data_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularLoanButtonCell extends StatelessWidget {
  final SelPopularListData? data;

  const PopularLoanButtonCell({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: BookBoxColor.black000,
      onTap: () {
        // TODO: 페이지 렌딩 구현
      },
      child: Row(
        children: [
          Text(
            data?.item?.no.toString() ?? '',
            style: TextStyle(
              fontFamily: BookBoxFontFamily.pretendardMedium,
              fontSize: 14.sp,
              color: BookBoxColor.indigo000,
            ),
          ),
          SizedBox(width: 11.w),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: 44.w,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Utils.getInstance().imageURlLoading(
                    url: data?.item?.bookImageURL ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                child: Text(
                  data?.item?.loanCount ?? '',
                  style: TextStyle(
                    fontFamily: BookBoxFontFamily.pretendardRegular,
                    fontSize: 9.sp,
                    color: BookBoxColor.black100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.item?.bookname ?? '',
                  style: TextStyle(
                    fontFamily: BookBoxFontFamily.pretendardBold,
                    fontSize: 14.sp,
                    color: BookBoxColor.indigo000,
                  ),
                ),
                Text(
                  data?.item?.authors ?? '',
                  style: TextStyle(
                    fontFamily: BookBoxFontFamily.pretendardRegular,
                    fontSize: 10.sp,
                    color: BookBoxColor.black100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
