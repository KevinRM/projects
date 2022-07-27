import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';

class TokenUtilityComp extends StatelessWidget {
  const TokenUtilityComp({Key? key, required this.languageState})
      : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.tokenUtilityTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Text(languageState.getText(TextKeys.tokenUtilityDescription)),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        LayoutBuilder(builder: ((context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: UtilitiesFunctions.isSmallScreen(context)
                      ? constraints.maxWidth
                      : constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(Constants.appDefaultPadding),
                  color: Constants.paletteSelected["medium"],
                  child: Text(languageState.getText(TextKeys.tokenUtility1))),
              const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
              Container(
                  alignment: Alignment.center,
                  width: UtilitiesFunctions.isSmallScreen(context)
                      ? constraints.maxWidth
                      : constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(Constants.appDefaultPadding),
                  color: Constants.paletteSelected["medium"],
                  child: Text(languageState.getText(TextKeys.tokenUtility2))),
              const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
              Container(
                  alignment: Alignment.center,
                  width: UtilitiesFunctions.isSmallScreen(context)
                      ? constraints.maxWidth
                      : constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(Constants.appDefaultPadding),
                  color: Constants.paletteSelected["medium"],
                  child: Text(languageState.getText(TextKeys.tokenUtility3))),
              const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
              Container(
                  alignment: Alignment.center,
                  width: UtilitiesFunctions.isSmallScreen(context)
                      ? constraints.maxWidth
                      : constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(Constants.appDefaultPadding),
                  color: Constants.paletteSelected["medium"],
                  child: Text(languageState.getText(TextKeys.tokenUtility4))),
              const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
              Container(
                  alignment: Alignment.center,
                  width: UtilitiesFunctions.isSmallScreen(context)
                      ? constraints.maxWidth
                      : constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(Constants.appDefaultPadding),
                  color: Constants.paletteSelected["medium"],
                  child: Text(languageState.getText(TextKeys.tokenUtility5))),
            ],
          );
        })),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Text(languageState.getText(TextKeys.tokenUtilityMore)),
      ],
    );
  }
}
