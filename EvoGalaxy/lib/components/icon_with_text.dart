import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

import '../constants.dart';
import 'custom_spacer.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {Key? key,
      required this.icon,
      required this.text,
      this.vertical = false,
      this.color})
      : super(key: key);

  final IconData icon;
  final String text;
  final bool vertical;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const CustomSpacer(
            verticalSpace: 5,
          ),
          AutoSizeText(
            text,
            maxFontSize: Constants.appBarFontSize,
            minFontSize: 5,
          )
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const CustomSpacer(
            horizontalSpace: 10,
          ),
          AutoSizeText(
            text,
            maxFontSize: Constants.appBarFontSize,
            minFontSize: 5,
          )
        ],
      );
    }
  }
}
