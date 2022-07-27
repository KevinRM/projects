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
      scaffoldBackgroundColor: Constants.paletteSelected["dark"]!,
      drawerTheme: DrawerThemeData(
          backgroundColor: Constants.paletteSelected["dark"]!, elevation: 0),
      primaryColor: Constants.paletteSelected["medium"]!,
      primaryColorDark: Constants.paletteSelected["dark"]!,
      primaryColorLight: Constants.paletteSelected["light"]!,
      fontFamily: "OpenSans",
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
              fontWeight: FontWeight.bold,
              letterSpacing: Constants.appFontLetterSpacing),
          primary: Constants.paletteSelected["accent"],
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20),
          // ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
      ),
      cardTheme: CardTheme(
        color: Constants.paletteSelected["medium"],
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: Constants.paletteSelected["light"]),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Constants.paletteSelected["icon"]),
          backgroundColor: Constants.paletteSelected["medium"]),
      iconTheme: IconThemeData(color: Constants.paletteSelected["icon"]),
      dividerTheme:
          DividerThemeData(color: Constants.paletteSelected["accent"]));

  // return theme.copyWith(
  //   colorScheme:
  //       theme.colorScheme.copyWith(secondary: Constants.secondaryColor),
  // );
  theme = theme.copyWith(
    textTheme: TextTheme(
      headline1: theme.textTheme.headline1
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      headline2: theme.textTheme.headline2
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      headline3: theme.textTheme.headline3
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      headline4: theme.textTheme.headline4
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      headline5: theme.textTheme.headline5
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      headline6: theme.textTheme.headline6
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      subtitle1: theme.textTheme.subtitle1?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing, fontSize: 14),
      subtitle2: theme.textTheme.subtitle2
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      bodyText1: theme.textTheme.bodyText1?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          fontSize: 14,
          height: 1.5),
      bodyText2: theme.textTheme.bodyText2?.copyWith(
          letterSpacing: Constants.appFontLetterSpacing,
          fontSize: 14,
          height: 1.5),
      button: theme.textTheme.button
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      caption: theme.textTheme.caption
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
      overline: theme.textTheme.overline
          ?.copyWith(letterSpacing: Constants.appFontLetterSpacing),
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
