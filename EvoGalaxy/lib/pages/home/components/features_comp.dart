import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';

class FeaturesComp extends StatelessWidget {
  const FeaturesComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    double maxHeightElements = 200;
    double maxWidthElements = 300;
    bool isSmallScreen = UtilitiesFunctions.isSmallScreen(context);
    List<Widget> elements =
        buildElements(maxWidthElements, maxHeightElements, isSmallScreen);
    return isSmallScreen
        ? Column(children: elements)
        : FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: elements),
          );
  }

  List<Widget> buildElements(
      double widthElements, double heightElements, bool isSmallScreen) {
    double cardPadding = 12;
    return [
      Column(
        children: [
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature1Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature1),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature2Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature2),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      CustomSpacer(
          horizontalSpace: isSmallScreen ? 0 : Constants.appDefaultSpacing,
          verticalSpace: isSmallScreen ? Constants.appDefaultSpacing : 0),
      Column(
        children: [
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature3Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature3),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature4Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature4),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      CustomSpacer(
          horizontalSpace: isSmallScreen ? 0 : Constants.appDefaultSpacing,
          verticalSpace: isSmallScreen ? Constants.appDefaultSpacing : 0),
      Column(
        children: [
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature5Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature5),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
          FittedBox(
            child: SizedBox(
              width: widthElements,
              height: heightElements,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                        languageState
                            .getText(TextKeys.projectFeature6Title)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const Divider(),
                      const CustomSpacer(verticalSpace: 12),
                      Text(languageState.getText(TextKeys.projectFeature6),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
