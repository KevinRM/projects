import 'package:flutter/material.dart';

class Constants {
  static const String appName = "EvoGALAXY";
  // static const String apiURL = "http://localhost:2567/api/";
  static const String apiURL = "https://api.evogalaxy.com:443/";

  // Social links
  static const String contactEmail = "contact@evogalaxy.com";
  static const String supportedCoins = "BTC - ETH - BNB - MATIC - USDT - USDC";
  static const String walletBSC = "0x8Ef48c040afEd1e959b08b91cd66B040D2CE49e1";
  static const String smartContractBSC = "";
  // static const String walletPOL = "POL";
  static const String twitterURL = "https://twitter.com/EvoGalaxyGame";
  static const String twitchURL = "https://www.twitch.tv/evogalaxygame";
  static const String discordURL = "https://discord.gg/Th8tPccnPX";
  static const String telegramURL = "https://t.me/evogalaxygame";

  // ===== Style
  static const String logoPath = "images/EvoGalaxy-logo-white-border.svg";
  // Colors
  static const Map<String, Color> paletteSelected = palette1;
  static const Map<String, Color> palette1 = {
    "dark": Color(0xFF041C32),
    "medium": Color(0xFF04293A),
    "light": Color(0xFF064663),
    "accent": Color(0xFFEDB550),
    "icon": Color(0xFFA0A4A7),
    "text": Color(0xFFEBEBEB)
  };
  static const Color textColor = Color(0xFFEBEBEB);
  // static const Color iconColor = Color(0xFFBFBFBF);
  static const Color successColor = Color(0xFF37B870);
  // static const Color warningColor = Color(0xFFFAC75A);
  static const Color dangerColor = Color(0xFFB84237);

  // Spaces
  static const double appDefaultSpacing = 15;
  static const double appDefaultPadding = 20;
  static const double appFontLetterSpacing = 0.8;

  // Sizes
  static const double appBarFontSize = 18;
  static const double appToolbarHeight = 70;

  // Durations
  static const Duration cMinSplashDuration = Duration(milliseconds: 1500);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  static const Duration checkSessionDuration = Duration(milliseconds: 60000);

  // static final RegExp emailValidatorRegExp =
  //     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
