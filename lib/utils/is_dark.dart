/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: is_dark
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/theme_provider.dart';

bool isDark(BuildContext context) {
  final themeAppearance = context.watch<ThemeProvider>().themeAppearence;

  if (themeAppearance == "system") {
    if (Theme.of(context).brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  } else if (themeAppearance == "dark") {
    return true;
  } else {
    return false;
  }
}

dynamic useThemeMode(
  BuildContext context, {
  required dynamic light,
  required dynamic dark,
}) {
  if (isDark(context)) {
    return dark;
  } else {
    return light;
  }
}
