import 'package:flutter/material.dart';

// Help class for responsive design
class SizeConfig {
  static const double incompatibleSizeWidth = 150;
  static const double incompatibleSizeHeight = 150;
  static const double verySmall = 350;
  static const double small = 576;
  static const double medium = 768;
  static const double large = 992;
  static const double extraLarge = 1200;

  static bool incompatibleScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < incompatibleSizeWidth ||
        MediaQuery.of(context).size.height < incompatibleSizeHeight;
  }

  static bool isVerySmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < verySmall;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < small;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < medium;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < large;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > large;
  }

  static int getNumColumns(BuildContext context) {
    if (isSmallScreen(context)) {
      return 1;
    } else if (isMediumScreen(context)) {
      return 2;
    } else if (isLargeScreen(context)) {
      return 3;
    } else if (isExtraLargeScreen(context)) {
      return 4;
    } else {
      return 1;
    }
  }
}
