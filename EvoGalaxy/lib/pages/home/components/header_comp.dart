import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';

class HeaderComp extends StatelessWidget {
  const HeaderComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 1.5),
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                image: AssetImage(
                  UtilitiesFunctions.parseFilePath("images/background2.jpg"),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: FittedBox(
                      child: Text(
                        Constants.appName,
                        style: TextStyle(fontSize: 62),
                      ),
                    ),
                  ),
                  // Subtitle
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        FittedBox(
                          child: Text(
                            languageState.getText(TextKeys.projectDescription1),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
