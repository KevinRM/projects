import 'package:evogalaxy/constants.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, this.colors}) : super(key: key);
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors ??
                  [
                    Constants.paletteSelected["dark"]!,
                    Constants.paletteSelected["accent"]!,
                    Constants.paletteSelected["dark"]!
                  ])),
    );
  }
}
