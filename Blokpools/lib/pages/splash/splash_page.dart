import 'package:blokstaking/constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.appDefaultPadding),
              child: SizedBox(width: 200, child: LinearProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
