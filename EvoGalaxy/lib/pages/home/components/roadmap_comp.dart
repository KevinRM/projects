import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';

class RoadmapComp extends StatelessWidget {
  const RoadmapComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;
  final double _bigBoxSize = 100;
  final double _smallBoxSize = 50;
  final double _borderSize = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.roadmapTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Text(languageState.getText(TextKeys.roadmapTokenAnnouncement),
            style: const TextStyle(fontSize: 18)),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Text(
            languageState.getText(TextKeys.roadmapLastUpdate) + " 22 Abr 2022"),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================
              // ===== 2022
              // ================
              buildBoxElement(
                  const Text("2022",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  true),
              buildElement(true, null),
              // ================
              // ====== Q2 ======
              // ================
              buildBoxElement(
                  const Text("Q2",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  true,
                  isSmall: true),
              buildElement(true,
                  Text(languageState.getText(TextKeys.roadmapWebsitePublish))),
              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapSpaceshipBuilderSystem))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapMultiplayer))),
              // ================
              // ====== Q3 ======
              // ================
              buildBoxElement(
                  const Text("Q3",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  false,
                  isSmall: true),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapShipControls))),
              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapGalaxyGeneratorAlgorithm))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapElementsAI))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapPlayerAccounts))),
              // ================
              // ====== Q4 ======
              // ================
              buildBoxElement(
                  const Text("Q4",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  false,
                  isSmall: true),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapAlphaVersion1))),

              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapPlayerInteractionsGalaxy))),
              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapSocialInteractions))),
              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapProgressionSystem))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapInGameEconomy))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapAlphaVersion2))),

              // ================
              // ===== 2023 =====
              // ================
              buildBoxElement(
                  const Text("2023",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  false),
              buildElement(false, null),
              // ================
              // ====== Q1 ======
              // ================
              buildBoxElement(
                  const Text("Q1",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  false,
                  isSmall: true),

              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapBattleSystem))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapRankingsSystem))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapAvatarCreation))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapAvatarInGame))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapBetaVersion))),
              // ================
              // ====== Q2 ======
              // ================
              buildBoxElement(
                  const Text("Q2",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  false,
                  isSmall: true),
              buildElement(
                  false,
                  Text(languageState
                      .getText(TextKeys.roadmapBuilderSystemNewAssets))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapSpaceStations))),
              buildBoxElement(const Text("..."), false),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapSmartContract))),
              buildElement(
                  false,
                  Text(
                      languageState.getText(TextKeys.roadmapTokenIntegration))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapMarketplace))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapNFTcreation))),
              buildElement(false,
                  Text(languageState.getText(TextKeys.roadmapTournaments))),
              buildElement(
                  false, Text(languageState.getText(TextKeys.roadmapVR))),
            ],
          ),
        ),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Text("*" + languageState.getText(TextKeys.roadmapDisclaimer),
            style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget buildElement(bool complete, Widget? element) {
    return Container(
      margin: EdgeInsets.only(left: (_bigBoxSize / 2) - (_borderSize / 2)),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
              width: _borderSize,
              color: complete
                  ? Constants.paletteSelected["light"]!
                  : Constants.paletteSelected["medium"]!),
        ),
      ),
      child: element != null
          ? Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      minWidth: (_bigBoxSize / 3),
                      minHeight: _borderSize,
                      maxHeight: _borderSize),
                  decoration: BoxDecoration(
                      color: complete
                          ? Constants.paletteSelected["light"]!
                          : Constants.paletteSelected["medium"]!),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: element,
                )
              ],
            )
          : null,
    );
  }

  Widget buildBoxElement(Widget child, bool complete, {bool isSmall = false}) {
    return Container(
      margin: isSmall
          ? EdgeInsets.only(left: (_bigBoxSize / 2) - (_smallBoxSize / 2))
          : null,
      decoration: BoxDecoration(
          color: Constants.paletteSelected["medium"],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: _borderSize,
              color: complete
                  ? Constants.paletteSelected["light"]!
                  : Constants.paletteSelected["medium"]!)),
      height: isSmall ? _smallBoxSize : _bigBoxSize,
      width: isSmall ? _smallBoxSize : _bigBoxSize,
      alignment: Alignment.center,
      child: child,
    );
  }
}
