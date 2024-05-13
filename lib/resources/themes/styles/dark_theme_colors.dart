import 'package:flutter/material.dart';
import '/resources/themes/styles/color_styles.dart';

/* Dark Theme Colors
|-------------------------------------------------------------------------- */

class DarkThemeColors implements ColorStyles {
  // general
  @override
  Color get background => Color.fromARGB(255, 41, 41, 41);

  @override
  Color get primaryContent => Color.fromARGB(255, 194, 194, 194);
  @override
  Color get primaryAccent => const Color(0xFF9999aa);

  @override
  Color get surfaceBackground => Colors.white70;
  @override
  Color get surfaceContent => Colors.black;

  // app bar
  @override
  Color get appBarBackground => Color.fromARGB(255, 105, 105, 105);
  @override
  Color get appBarPrimaryContent => Colors.white;

  // buttons
  @override
  Color get buttonBackground => Colors.white60;
  @override
  Color get buttonPrimaryContent => const Color(0xFF232c33);

  // bottom tab bar
  @override
  Color get bottomTabBarBackground => const Color(0xFF232c33);

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

  Color get cardColor => Colors.white;
}
