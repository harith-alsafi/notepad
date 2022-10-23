import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

Route routeAnimation(Widget Function(BuildContext context) page) {
  return PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return SharedAxisTransition(
      fillColor: Theme.of(context).cardColor,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }, pageBuilder: (context, animation, secondaryAnimation) {
    return page(context);
  });
}
