import 'package:blokstaking/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.child, this.constraints})
      : super(key: key);

  final Widget child;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: constraints,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Constants.paletteSelected["shadow"]!.withOpacity(0.55),
              blurRadius: 40)
        ]),
        child: Card(child: child));
  }
}
