import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/pages/home/components/social_networks_comp.dart';
import 'package:evogalaxy/router/my_router.dart';
import 'package:evogalaxy/router/router_delegate.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterComp extends StatelessWidget {
  const FooterComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Constants.paletteSelected["medium"]),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          const CustomSpacer(verticalSpace: 34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SvgPicture.asset(
                            UtilitiesFunctions.parseFilePath(
                                Constants.logoPath),
                            fit: BoxFit.scaleDown,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Flexible(child: FittedBox(child: SocialNetworks())),
                      ],
                    ),
                    const CustomSpacer(
                        verticalSpace: Constants.appDefaultSpacing),
                    Wrap(
                      children: [
                        TextButton(
                            onPressed: () => MyRouterDelegate.of(context)
                                .changePage(MyRouterPath.terms()),
                            child: Text(languageState
                                .getText(TextKeys.footerTermsMenu))),
                        TextButton(
                            onPressed: () => MyRouterDelegate.of(context)
                                .changePage(MyRouterPath.privacy()),
                            child: Text(languageState
                                .getText(TextKeys.footerPrivacyMenu)))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const CustomSpacer(verticalSpace: 34),
          Text(
              languageState.getText(TextKeys.footerSmartContractAddress) +
                  " " +
                  Constants.smartContractBSC,
              style: const TextStyle(fontSize: 9)),
          const CustomSpacer(verticalSpace: 34),
          Text(
              "Copyright © " +
                  DateTime.now().year.toString() +
                  " EvoGalaxy. All Rights Reserved",
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          Text(languageState.getText(TextKeys.disclaimer1),
              style: const TextStyle(fontSize: 9)),
          Text(languageState.getText(TextKeys.disclaimer2),
              style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}
