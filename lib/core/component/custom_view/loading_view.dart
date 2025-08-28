import 'package:book_box_2/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class LoadingView {
  static OverlayEntry? overlayEntry;

  static void show(BuildContext context) {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder:
            (BuildContext context) => Positioned.fill(
              child: Material(
                color: BookBoxColor.black000.withAlpha(30),
                child: Center(
                  child: CircularProgressIndicator(color: BookBoxColor.grey000),
                ),
              ),
            ),
      );

      Overlay.of(context).insert(overlayEntry!);
    }
  }

  static void hide() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
