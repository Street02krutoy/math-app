import 'package:flutter/material.dart';

extension context_ext on BuildContext {
  NavigatorState get nav => Navigator.of(this);
  ThemeData get theme => Theme.of(this);
}
