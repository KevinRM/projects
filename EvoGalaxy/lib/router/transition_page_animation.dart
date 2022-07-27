import 'package:evogalaxy/constants.dart';
import 'package:flutter/material.dart';

class TransitionPageAnimation extends Page {
  const TransitionPageAnimation({
    required this.child,
    required this.keyParam,
    required this.nameParam,
  }) : super(key: keyParam, name: nameParam);

  final Widget child;
  final ValueKey keyParam;
  final String nameParam;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: Constants.pageTransitionDuration,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return child;
      },
    );
  }
}
