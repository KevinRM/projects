import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);
  static const valueKey = ValueKey("noInternetPage");

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Your device does not have internet access"),
      ),
    );
  }
}
