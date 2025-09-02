// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:book_box_2/gen/colors.gen.dart';
import 'package:book_box_2/gen/fonts.gen.dart';

class BookDetailPage extends StatefulWidget {
  final String? isbn;
  const BookDetailPage({super.key, required this.isbn});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late final String isbn;

  @override
  void initState() {
    isbn = widget.isbn!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BookBoxColor.grey400,
      child: Container(
        color: BookBoxColor.yellow000,
        child: Center(
          child: Text(
            'DetailPage >>> $isbn',
            style: TextStyle(
              color: BookBoxColor.black000,
              fontSize: 20.sp,
              fontFamily: BookBoxFontFamily.pretendardBold,
            ),
          ),
        ),
      ),
    );
  }
}
