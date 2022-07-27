import 'package:flutter/material.dart';

enum SupportedStylesKeys {
  bold,
  italic,
  underline,
  aligmentLeft,
  aligmentCenter,
  aligmentRight
}

class SupportedStyles {
  static RegExp regExpToCheckFormat = RegExp(
      r"(\/\s*(b|u|i)+(\s|\/)*(b|u|i)+\s*\/|\/\s*(b|u|i)\s*\/)",
      multiLine: true);
  static RegExp regExpStyles = RegExp(r"\/(b|i|u)+\/", multiLine: true);
  static const String symbol = "/";
  static const Map<SupportedStylesKeys, String> styles = {
    SupportedStylesKeys.bold: "b",
    SupportedStylesKeys.italic: "i",
    SupportedStylesKeys.underline: "u",
  };
  static const Map<SupportedStylesKeys, TextAlign> aligment = {
    SupportedStylesKeys.aligmentLeft: TextAlign.left,
    SupportedStylesKeys.aligmentCenter: TextAlign.center,
    SupportedStylesKeys.aligmentRight: TextAlign.right,
  };

  static List<String> parseCommand(List<String> currentStyles, String command) {
    for (var i = 0; i < command.length; i++) {
      if (command[i] == styles[SupportedStylesKeys.bold]) {
        String bold = styles[SupportedStylesKeys.bold]!;
        currentStyles.contains(bold)
            ? currentStyles.removeWhere((element) => element == bold)
            : currentStyles.add(bold);
      } else if (command[i] == styles[SupportedStylesKeys.italic]) {
        String italic = styles[SupportedStylesKeys.italic]!;
        currentStyles.contains(italic)
            ? currentStyles.removeWhere((element) => element == italic)
            : currentStyles.add(italic);
      } else if (command[i] == styles[SupportedStylesKeys.underline]) {
        String underline = styles[SupportedStylesKeys.underline]!;
        currentStyles.contains(underline)
            ? currentStyles.removeWhere((element) => element == underline)
            : currentStyles.add(underline);
      }
    }

    return currentStyles;
  }
}
