import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

// App Theme
ThemeData theme() {
  ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(Constants.paletteSelected["medium"]!.value, {
      50: tintColor(Constants.paletteSelected["medium"]!, 0.9),
      100: tintColor(Constants.paletteSelected["medium"]!, 0.8),
      200: tintColor(Constants.paletteSelected["medium"]!, 0.6),
      300: tintColor(Constants.paletteSelected["medium"]!, 0.4),
      400: tintColor(Constants.paletteSelected["medium"]!, 0.2),
      500: Constants.paletteSelected["medium"]!,
      600: shadeColor(Constants.paletteSelected["medium"]!, 0.1),
      700: shadeColor(Constants.paletteSelected["medium"]!, 0.2),
      800: shadeColor(Constants.paletteSelected["medium"]!, 0.3),
      900: shadeColor(Constants.paletteSelected["medium"]!, 0.4),
    }),
    scaffoldBackgroundColor: Constants.paletteSelected["background"]!,
    drawerTheme: DrawerThemeData(
        backgroundColor: Constants.paletteSelected["dark"]!, elevation: 0),
    primaryColor: Constants.paletteSelected["medium"]!,
    primaryColorDark: Constants.paletteSelected["dark"]!,
    primaryColorLight: Constants.paletteSelected["light"]!,
    fontFamily: Constants.fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Constants.paletteSelected["text"]),
    ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     // primary: Constants.textGreyColor,
    //     side: const BorderSide(color: Constants.secondaryColor),
    //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   ),
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          // minimumSize: const Size(150, 40),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: Constants.fontFamily,
              letterSpacing: Constants.appFontLetterSpacing),
          primary: Constants.paletteSelected["medium"],
          onPrimary: Constants.paletteSelected["text"],
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Constants.appDefaultBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18)),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.paletteSelected["error"]!)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.paletteSelected["error"]!)),
        isDense: false,
        contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
        errorStyle: TextStyle(color: Constants.paletteSelected["error"])),
    cardTheme: CardTheme(
      color: Constants.paletteSelected["dark"],
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(Constants.appDefaultBorderRadius)),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Constants.paletteSelected["light"]!, width: 1.5),
          borderRadius:
              BorderRadius.circular(Constants.appDefaultBorderRadius)),
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: Constants.paletteSelected["light"]),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Constants.paletteSelected["icon"]),
        backgroundColor: Constants.paletteSelected["dark"]),
    iconTheme:
        IconThemeData(color: Constants.paletteSelected["icon"], size: 28),
    dividerTheme: DividerThemeData(color: Constants.paletteSelected["light"]),
    popupMenuTheme: PopupMenuThemeData(
      color: Constants.paletteSelected["dark"],
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Constants.paletteSelected["medium"]!, width: 1),
      ),
    ),
  );

  theme = theme.copyWith(
    textTheme: TextTheme(
      headline1: theme.textTheme.headline1?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      headline2: theme.textTheme.headline2?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      headline3: theme.textTheme.headline3?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      headline4: theme.textTheme.headline4?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      headline5: theme.textTheme.headline5?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      headline6: theme.textTheme.headline6?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      subtitle1: theme.textTheme.subtitle1?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          fontSize: Constants.appDefaultFontSize,
          color: Constants.paletteSelected["text"]),
      subtitle2: theme.textTheme.subtitle2?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      bodyText1: theme.textTheme.bodyText1?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          fontSize: Constants.appDefaultFontSize,
          // height: 2,
          color: Constants.paletteSelected["text"]),
      bodyText2: theme.textTheme.bodyText2?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          fontSize: Constants.appDefaultFontSize,
          // height: 2,
          color: Constants.paletteSelected["text"]),
      button: theme.textTheme.button?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      caption: theme.textTheme.caption?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
      overline: theme.textTheme.overline?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          color: Constants.paletteSelected["text"]),
    ),
  );

  return theme;
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
