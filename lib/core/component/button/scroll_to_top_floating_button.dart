// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 상단부로 스크롤 되는 버튼
// primaryscrollcontroller의 jumpto 기능 ???!?!?
class ScrollToTopFloatingButton extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double? positionBottom;
  final double? positionRight;
  final bool alwaysVisible;

  const ScrollToTopFloatingButton({
    super.key,
    required this.child,
    required this.scrollController,
    this.positionBottom,
    this.positionRight,
    this.alwaysVisible = false,
  });

  @override
  State<ScrollToTopFloatingButton> createState() =>
      _ScrollToTopFloatingButtonState();
}

class _ScrollToTopFloatingButtonState extends State<ScrollToTopFloatingButton>
    with AutomaticKeepAliveClientMixin {
  // AutomaticKeepAliveClientMixin : 위젯을 보존하고 상태를 유지
  late bool _show = false;
  late bool _alwaysVisible;

  final double _defaultBottomPosition = 50.h;
  final double _defaultRightPosition = 20.h;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _alwaysVisible = widget.alwaysVisible;
    widget.scrollController.addListener(_scrollListener);

    // 위젯이 빌드 된 후에 콜백 함수 실행하기 위해 addPostFrameCallback 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_alwaysVisible &&
          widget.scrollController.position.maxScrollExtent > 0) {
        setState(() {
          _show = true;
        });
      } else {
        _alwaysVisible = false;
      }
    });
  }

  @override
  void dispose() {
    // 위젯이 영구적으로 제거될 때 호출
    // 리소스 정리, 리스너 해제, 애니메이션 컨트롤러 중지, 스트림 구독 해제, 타이머 및 기타 콜백 취소
    super.dispose();
    widget.scrollController.dispose();
  }

  void _scrollListener() {
    if (!_alwaysVisible) {
      setState(() {
        _show = widget.scrollController.offset >= 200 ? true : false;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: widget.positionBottom ?? _defaultBottomPosition,
          right: widget.positionRight ?? _defaultRightPosition,
          child: Visibility(
            visible: _show,
            child: GestureDetector(
              onTap: () => _scrollToTop(),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                margin: EdgeInsets.zero,
                width: 36.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: BookBoxColor.c283a7d,
                      offset: const Offset(0, 1),
                      blurRadius: 8.r,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SvgPicture.asset(
                    BookBoxAssets.images.arrowUpward.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
