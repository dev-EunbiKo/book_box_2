import 'package:book_box_2/core/extensions/extension_object.dart';
import 'package:book_box_2/core/navigation/routes.dart';
import 'package:book_box_2/navigation.dart';
import 'package:flutter/material.dart';

enum AnimationDirection {
  fadeInOut,
  leftToRight,
  rightToLeft,
  downToUp,
  upToDown,
  none,
}

/// Route로부터 받은 정보를 가지고 push/pop 해서 표시할 위젯, 전환 효과를 Navigator에 전달
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void push(String routeName, {AnimationDirection? direction}) {
    if (Routes.routes[routeName] == null) {
      routeName = Routes.navigation;
    }

    navigatorKey.currentContext?.ifNotNull((buildContext) {
      if (direction == null) {
        Navigator.of(buildContext).pushNamed(routeName);
      } else {
        Navigator.of(buildContext).push(_createRoute(routeName, direction));
      }
    });
  }

  static void pushAndRemoveStack(
    String routeName, {
    int? tabIndex,
    AnimationDirection? direction,
  }) {
    if (Routes.routes[routeName] == null) {
      routeName = Routes.navigation;
    }

    if (routeName == Routes.navigation &&
        tabIndex != null &&
        (NavigationState.naviKey.currentWidget) != null) {
      navigatorKey.currentContext?.ifNotNull(
        (buildContext) => {
          Navigator.of(buildContext).popUntil((route) => route.isFirst),
          (NavigationState.naviKey.currentWidget as BottomNavigationBar).onTap!(
            tabIndex,
          ),
        },
      );
    } else {
      navigatorKey.currentContext?.ifNotNull(
        (buildContext) => {
          Navigator.of(buildContext).pushAndRemoveUntil(
            direction == null
                ? MaterialPageRoute(
                  builder:
                      (_) =>
                          (routeName == Routes.navigation && tabIndex != null)
                              ? Navigation(selectedIndex: tabIndex)
                              : Routes.routes[routeName]!(buildContext),
                )
                : _createRoute(routeName, direction),
            (route) => false,
          ),
        },
      );
    }
  }

  static void safePop(String routeName, {AnimationDirection? direction}) {
    if (Routes.routes[routeName] == null) {
      routeName = Routes.navigation;
    }

    navigatorKey.currentContext?.ifNotNull(
      (buildContext) => {
        if (Navigator.of(buildContext).canPop())
          {Navigator.of(buildContext).pop()}
        else
          {
            direction == null
                ? Navigator.of(buildContext).pushReplacementNamed(routeName)
                : Navigator.of(
                  buildContext,
                ).pushReplacement(_createRoute(routeName, direction)),
          },
      },
    );
  }

  static Route _createRoute(String routeName, AnimationDirection direction) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Routes.routes[routeName]!(context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(child, animation, direction);
      },
    );
  }

  static Widget _buildTransition(
    Widget child,
    Animation<double> animation,
    AnimationDirection? direction,
  ) {
    switch (direction) {
      case AnimationDirection.rightToLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case AnimationDirection.leftToRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case AnimationDirection.downToUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case AnimationDirection.upToDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case AnimationDirection.fadeInOut:
        return FadeTransition(
          opacity: animation,
          child: child,
        ); // Implementing fadeIn
      default:
        return child; // No animation
    }
  }
}
