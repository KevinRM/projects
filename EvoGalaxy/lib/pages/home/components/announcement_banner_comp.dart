import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';

class AnnouncementBannerComp extends StatelessWidget {
  const AnnouncementBannerComp({Key? key, required this.languageState})
      : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    String adBannerText = languageState.getText(TextKeys.adBanner);
    return adBannerText.isNotEmpty
        ? Container(
            decoration:
                BoxDecoration(color: Constants.paletteSelected["light"]),
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                adBannerText,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ))
        : const SizedBox();
  }
}
