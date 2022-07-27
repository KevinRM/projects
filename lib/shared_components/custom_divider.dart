import 'package:flutter/material.dart';

import '../constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider(
      {Key? key,
      this.colors,
      this.height = 1,
      this.vertical = false,
      this.margin = 8.0})
      : super(key: key);
  final List<Color>? colors;
  final bool vertical;
  final double height;
  final double margin;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Container(
        width: 2,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors ??
                    [
                      Constants.paletteSelected["dark"]!,
                      Constants.paletteSelected["light"]!,
                      Constants.paletteSelected["dark"]!
                    ])),
      );
    } else {
      return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: margin),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colors ??
                    [
                      Constants.paletteSelected["dark"]!,
                      Constants.paletteSelected["light"]!,
                      Constants.paletteSelected["dark"]!
                    ])),
      );
    }
  }
}
