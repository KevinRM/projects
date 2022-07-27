import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PartnersComp extends StatelessWidget {
  const PartnersComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.partnersTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        FittedBox(
          child: Row(
            children: [
              Text(
                languageState.getText(TextKeys.partnersBecomePartner) + " ",
                style: const TextStyle(fontSize: 12),
              ),
              Tooltip(
                  message: languageState.getText(TextKeys.copy),
                  child: InkWell(
                    onTap: () => UtilitiesFunctions.copyToClipboard(
                        context, Constants.contactEmail),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Constants.paletteSelected["text"]!)),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(Constants.contactEmail),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
