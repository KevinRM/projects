import "package:flutter/material.dart";
import 'custom_spacer.dart';

/// Custom icon with text. Can be horizontal or vertical
class IconWithText extends StatelessWidget {
  const IconWithText(
      {Key? key,
      required this.icon,
      required this.text,
      this.vertical = false,
      this.color,
      this.fontSize,
      this.iconSize})
      : super(key: key);

  final IconData icon;
  final String text;
  final bool vertical;
  final Color? color;
  final double? fontSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      List<Widget> children = [
        Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      ];

      if (text.isNotEmpty) {
        children.add(const CustomSpacer(
          verticalSpace: 5,
        ));
        children.add(Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ));
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSpacer(
            verticalSpace: 5,
          ),
          ...children,
          const CustomSpacer(
            verticalSpace: 5,
          ),
        ],
      );
    } else {
      List<Widget> children = [
        Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      ];

      if (text.isNotEmpty) {
        children.add(const CustomSpacer(
          horizontalSpace: 10,
        ));
        children.add(Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ));
      }

      return Row(
        children: [
          const CustomSpacer(
            horizontalSpace: 10,
          ),
          ...children,
          const CustomSpacer(
            horizontalSpace: 10,
          ),
        ],
      );
    }
  }
}
