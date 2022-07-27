import 'package:flutter/material.dart';

class Constants {
  static const String appNameVersion = "Alpha";
  static const String appName = "My Mind";
  static const String apiURL = "http://localhost:3000/api/";

  // Social links
  static const String twitter = "";
  static const String instagram = "";
  static const String facebook = "";
  static const String tiktok = "";

  // Paths
  static const String logoPath = "images/logo.png";
  static const String fontFamily = "OpenSans";

  // Colors
  static const Map<String, Color> paletteSelected = paletteBeach;
  static const Map<String, Color> paletteBeach = {
    "background": Color.fromARGB(255, 0, 27, 25),
    "dark": Color(0xFF045346),
    "medium": Color(0xFF8DA56C),
    "light": Color(0xFFE2C18B),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFE2C18B),
    "error": Color(0xFFF8B2A1),
    "success": Color(0xFFD2E0DB),
  };
  static const Map<String, Color> paletteSea = {
    "background": Color(0xFF223542),
    "dark": Color(0xFF2B506E),
    "medium": Color(0xFF4F87A2),
    "light": Color(0xFFC0CFD6),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFFE9E4EA),
  };

  static const Map<String, Color> paletteWorldFlower = {
    "background": Color.fromARGB(255, 24, 15, 17),
    "dark": Color(0xFF6B434C),
    "medium": Color(0xFF9B878B),
    "light": Color(0xFFFDCF73),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF8B2A1),
    "success": Color(0xFFE88846),
  };

  static const Map<String, Color> paletteFlower = {
    "background": Color(0xFF282C1F),
    "dark": Color(0xFF66734A),
    "medium": Color(0xFFA8AB74),
    "light": Color(0xFFD9DDC1),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFFB0ADA8),
  };
  static const Map<String, Color> paletteAfternoon = {
    "background": Color(0xFF292326),
    "dark": Color(0xFF42373D),
    "medium": Color(0xFF9A7EA6),
    "light": Color(0xFFC4889F),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF8B2A1),
    "success": Color(0xFFFDE2B1),
  };

  static const Map<String, Color> palette1 = {
    "background": Color(0xFF1E2714),
    "dark": Color(0xFF6b9b37),
    "medium": Color(0xFF9ccc65),
    "light": Color(0xFFcfff95),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFF37B870),
  };
  static const Map<String, Color> palette2 = {
    "background": Color(0xFF454D3D),
    "dark": Color(0xFF3B4D26),
    "medium": Color(0xFF75994C),
    "light": Color(0xFF9CCC65),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFF37B870),
  };
  static const Map<String, Color> palette4 = {
    "background": Color(0xFF314A3A),
    "dark": Color(0xFF1B4A2D),
    "medium": Color(0xFF639677),
    "light": Color(0xFF85CAA0),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFF37B870),
  };
  static const Map<String, Color> palette5 = {
    "background": Color(0xFF354736),
    "dark": Color(0xFF1F4721),
    "medium": Color(0xFF6D946F),
    "light": Color(0xFF93C796),
    "icon": Color(0xFFEBEBEB),
    "text": Color(0xFFEBEBEB),
    "warning": Color(0xFFFFA53E),
    "error": Color(0xFFF3FF4E),
    "success": Color(0xFF5CD061),
  };

  // Spaces
  static const double appFontLetterSpacing = 0.3;
  static const double appPaddingScreenBorder = 12.0;

  // Sizes
  static const double appBarFontSize = 18;
  static const double appDefaultFontSize = 16;
  static const double appToolbarHeight = 56;
  static const double appDefaultBorderRadius = 8.0;

  // Durations
  static const Duration deleteAccountNoVerification = Duration(days: 5);
  static const Duration splashDuration = Duration(milliseconds: 1500);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  static const Duration checkSessionDuration = Duration(seconds: 30);

  // General
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const int minPassLength = 8;
  static const int maxNoteTitleLength = 50;
  static const int maxNoteTextElementLenght = 300;
}
