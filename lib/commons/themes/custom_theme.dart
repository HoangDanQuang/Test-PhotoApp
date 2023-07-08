import 'package:flutter/material.dart';
import 'package:test_intesco/commons/themes/custom_theme_data.dart';

class CustomTheme {
  static ThemeData get dark => getThemeData(true);

  static ThemeData get light => getThemeData(false);

  // static PresetColors colors(BuildContext context) {
  //   return Theme.of(context).brightness == Brightness.dark
  //       ? _presetDarkColors
  //       : _presetColors;
  // }

  // static final PresetColors _presetColors = PresetColors(isDark: false);
  // static final PresetColors _presetDarkColors =
  //     PresetColors(isDark: true, backgroundColor: Color(0xFF141414));

  ThemeMode mode = ThemeMode.system;
}
