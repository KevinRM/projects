import 'package:blokstaking/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
        child: Text(
          text,
          style: const TextStyle(
              letterSpacing: 0.5, fontWeight: FontWeight.w900, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
