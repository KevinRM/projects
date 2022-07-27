import 'package:flutter/material.dart';

class Constants {
  static const String appName = "BLOK Staking";
  // static const String apiURL = "http://localhost:2567/api/";
  static const String apiURL = "https://blokpools.herokuapp.com/api/";

  // Social links
  static const String walletTo = "0x944150FC79Bfe65A2901417C5AC85f606d6339E9";
  // static const String tokenBlokContract =
  //     "0x229b1b6C23ff8953D663C4cBB519717e323a0a84";
  static const String tokenMaticContract =
      "0x0000000000000000000000000000000000001010";

  // ===== Style
  static const String logoPath = "images/bloktopia-logo.png";
  static const String iconPath = "images/bloktopia-icon.png";
  static const String metamaskIconPath = "images/metamask.png";
  // Colors
  static const Map<String, Color> paletteSelected = palette1;
  static const Map<String, Color> palette1 = {
    "dark": Color(0xFF000000),
    "medium": Color(0xFF9c28ec),
    "light": Color(0xFFfe28d6),
    "accent": Color(0xFFfe28d6),
    "shadow": Color(0xFFfe28d6),
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
  static const double appFontLetterSpacing = 0; //0.8;

  // Sizes
  static const double appBarFontSize = 18;
  static const double appToolbarHeight = 135;

  // Durations
  static const Duration cMinSplashDuration = Duration(milliseconds: 0);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  static const Duration checkSessionDuration = Duration(milliseconds: 60000);

  // static final RegExp emailValidatorRegExp =
  //     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
