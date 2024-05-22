import 'package:flutter/material.dart';
import '/resources/themes/styles/color_styles.dart';

/* Dark Theme Colors
|-------------------------------------------------------------------------- */

class DarkThemeColors implements ColorStyles {
  // general
  @override
  Color get background => Color.fromRGBO(51, 51, 51, 1);

  @override
  Color get primaryContent => Color.fromRGBO(238, 238, 238, 1);
  @override
  Color get primaryAccent => const Color.fromRGBO(255, 221, 45, 1);

  @override
  Color get surfaceBackground => Colors.white70;
  @override
  Color get surfaceContent => Colors.black;

  // app bar
  @override
  Color get appBarBackground => Color.fromRGBO(51, 51, 51, 1);
  @override
  Color get appBarPrimaryContent => Color.fromRGBO(238, 238, 238, 1);

  // buttons
  @override
  Color get buttonBackground => Colors.white60;
  @override
  Color get buttonPrimaryContent => const Color(0xFF232c33);

  // bottom tab bar
  @override
  Color get bottomTabBarBackground => Color.fromRGBO(51, 51, 51, 1);

  // bottom tab bar - icons
  @override
  Color get bottomTabBarIconSelected => Colors.white70;
  @override
  Color get bottomTabBarIconUnselected => Colors.white60;

  // bottom tab bar - label
  @override
  Color get bottomTabBarLabelUnselected => Colors.white54;
  @override
  Color get bottomTabBarLabelSelected => Colors.white;

  @override
  Color get cardColor => Color.fromRGBO(64, 64, 64, 1);

  @override
  Color get secondary => Color.fromARGB(255, 71, 167, 247);
}
