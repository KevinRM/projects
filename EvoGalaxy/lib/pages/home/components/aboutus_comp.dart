import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';

class AboutusComp extends StatelessWidget {
  const AboutusComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.aboutUsTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(languageState.getText(TextKeys.aboutUs1)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.aboutUs2)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.aboutUs3)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.aboutUs4)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.aboutUs5)),
          ],
        )
      ],
    );
  }
}
