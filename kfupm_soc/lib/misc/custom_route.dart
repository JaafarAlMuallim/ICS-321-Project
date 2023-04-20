import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomRoute({
    required this.child,
    required this.direction,
  }) : super(
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
      default:
        null;
    }
    return const Offset(-1, 0);
  }
}
