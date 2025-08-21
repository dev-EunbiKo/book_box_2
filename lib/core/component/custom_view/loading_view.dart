import 'package:book_box_2/core/extensions/extension_object.dart';
import 'package:book_box_2/core/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class LoadingView {
  static OverlayEntry? overlayEntry;

  static void show({BuildContext? context}) {
    // ignore: prefer_conditional_assignment
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder:
            (BuildContext context) => Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
      );
      if (context == null) {
        NavigationService.navigatorKey.currentContext?.ifNotNull((
          buildContext,
        ) {
          overlayEntry?.ifNotNull(
            (overlay) => {Overlay.of(buildContext).insert(overlay)},
          );
        });
      } else {
        overlayEntry?.ifNotNull(
          (overlay) => {Overlay.of(context).insert(overlay)},
        );
      }
    } else {
      debugPrint('오버레이 >>> ');
    }
  }

  static void hide() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
