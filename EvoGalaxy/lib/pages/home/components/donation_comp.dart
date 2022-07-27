import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';

class DonationComp extends StatelessWidget {
  const DonationComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.donationTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(languageState.getText(TextKeys.donationText1)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.donationText2)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.donationText3)),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
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
                    child: Text(languageState.getText(TextKeys.email) +
                        ": " +
                        Constants.contactEmail),
                  ),
                )),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Tooltip(
                message: languageState.getText(TextKeys.copy),
                child: InkWell(
                  onTap: () => UtilitiesFunctions.copyToClipboard(
                      context, Constants.walletBSC),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Constants.paletteSelected["text"]!)),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        languageState.getText(TextKeys.donationWalletBSC) +
                            ": " +
                            Constants.walletBSC),
                  ),
                )),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            Text(languageState.getText(TextKeys.donationSuppCoins) +
                ": " +
                Constants.supportedCoins),
          ],
        )
      ],
    );
  }
}
