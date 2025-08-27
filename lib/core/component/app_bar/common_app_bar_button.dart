import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CommonAppBarButtonType { back, share, close, search, text, plus }

class CommonAppBarButton extends StatelessWidget {
  final CommonAppBarButtonType type;
  final VoidCallback onPressed;

  const CommonAppBarButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: BookBoxColor.black000,
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: _getButtonTypeIcon(type),
      ),
    );
  }

  _getButtonTypeIcon(CommonAppBarButtonType type) {
    switch (type) {
      case CommonAppBarButtonType.back:
        _setButtonIcon(BookBoxAssets.images.icArrowLeft.path);
      case CommonAppBarButtonType.close:
        _setButtonIcon(BookBoxAssets.images.icClose.path);
      case CommonAppBarButtonType.share:
        _setButtonIcon(BookBoxAssets.images.icShare.path);
      case CommonAppBarButtonType.search:
        _setButtonIcon(BookBoxAssets.images.icSearch.path);
      case CommonAppBarButtonType.plus:
        _setButtonIcon(BookBoxAssets.images.icAdd.path);
      default:
        _setButtonIcon(BookBoxAssets.images.icArrowLeft.path);
    }
  }

  _setButtonIcon(String assetName) {
    return SizedBox(
      width: 24.w,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: SvgPicture.asset(assetName, fit: BoxFit.contain),
      ),
    );
  }
}
