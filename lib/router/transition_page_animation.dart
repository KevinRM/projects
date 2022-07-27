import 'package:flutter/material.dart';

import '../constants.dart';

class TransitionPageAnimation extends Page {
  const TransitionPageAnimation({
    required this.child,
    required this.keyParam,
    required this.nameParam,
    this.durationParamMS = -1,
  }) : super(key: keyParam, name: nameParam);

  final Widget child;
  final UniqueKey keyParam;
  final String nameParam;
  final int durationParamMS;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: durationParamMS > -1
          ? Duration(milliseconds: durationParamMS)
          : Constants.pageTransitionDuration,
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
