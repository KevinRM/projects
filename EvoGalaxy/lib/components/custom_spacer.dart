import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({Key? key, this.horizontalSpace, this.verticalSpace})
      : super(key: key);

  final double? horizontalSpace;
  final double? verticalSpace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpace ?? 0,
      height: verticalSpace ?? 0,
    );
  }
}
