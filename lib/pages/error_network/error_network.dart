import 'package:flutter/material.dart';

class ErrorNetworkPage extends StatelessWidget {
  const ErrorNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Your device does not have internet access"),
      ),
    );
  }
}
