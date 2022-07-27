import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);
  static const valueKey = ValueKey("noInternetPage");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            context.read<LanguageState>().getText(TextKeys.noInternetAccess)),
      ),
    );
  }
}
