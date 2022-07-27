import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/router/router_delegate.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageState = context.read<LanguageState>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Constants.appDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FittedBox(
                                child: Text(
                              languageState.getText(TextKeys.unknownPage),
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            )),
                            const CustomSpacer(
                              verticalSpace: Constants.appDefaultSpacing,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                MyRouterDelegate.of(context).resetToHome();
                              },
                              child: Text(
                                  languageState.getText(TextKeys.backText)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
