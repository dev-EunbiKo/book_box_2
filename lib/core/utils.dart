import 'package:book_box_2/gen/assets.gen.dart';
import 'package:book_box_2/gen/colors.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Utils {
  const Utils._();

  static Utils getInstance() {
    return const Utils._();
  }

  /// 이미지 로딩
  /// 이미지 로딩
  Widget imageURlLoading({
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    bool isBgWhite = false,
  }) {
    if (url == '') {
      return _imagePlaceHolder(width, height, isBgWhite);
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      // memCacheHeight: height?.toInt(),
      // memCacheWidth: width?.toInt(),
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 700),
      fit: fit,
      placeholder: (context, url) {
        return _imagePlaceHolder(width, height, isBgWhite);
      },
      errorWidget: (context, url, error) {
        return _imagePlaceHolder(width, height, isBgWhite);
      },
    );
  }

  /// imageURlLoading placeholder
  Widget _imagePlaceHolder(double? width, double? height, bool isBgWhite) {
    return Container(
      color: isBgWhite ? BookBoxColor.white000 : BookBoxColor.white100,
      child: SvgPicture.asset(
        BookBoxAssets.images.icError.path,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
