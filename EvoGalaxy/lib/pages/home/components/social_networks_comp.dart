import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialNetworks extends StatelessWidget {
  const SocialNetworks({Key? key, this.defaultSize = 32}) : super(key: key);
  final double defaultSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            iconSize: defaultSize,
            icon: SvgPicture.asset(
              UtilitiesFunctions.parseFilePath("icons/socialMedia/twitter.svg"),
              color: Constants.paletteSelected["icon"],
            ),
            onPressed: () => UtilitiesFunctions.openURL(Constants.twitterURL)),
        IconButton(
            iconSize: defaultSize,
            icon: SvgPicture.asset(
              UtilitiesFunctions.parseFilePath("icons/socialMedia/discord.svg"),
              color: Constants.paletteSelected["icon"],
            ),
            onPressed: () => UtilitiesFunctions.openURL(Constants.discordURL)),
        IconButton(
            iconSize: defaultSize,
            icon: SvgPicture.asset(
              UtilitiesFunctions.parseFilePath(
                  "icons/socialMedia/telegram.svg"),
              color: Constants.paletteSelected["icon"],
            ),
            onPressed: () => UtilitiesFunctions.openURL(Constants.telegramURL)),
        IconButton(
            iconSize: defaultSize,
            icon: SvgPicture.asset(
              UtilitiesFunctions.parseFilePath("icons/socialMedia/twitch.svg"),
              color: Constants.paletteSelected["icon"],
            ),
            onPressed: () => UtilitiesFunctions.openURL(Constants.twitchURL)),
      ],
    );
  }
}
