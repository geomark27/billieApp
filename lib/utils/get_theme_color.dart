/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: get_theme_color
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/theme_colors.dart';
import 'package:salepro/providers/theme_provider.dart';

MaterialColor? getThemeColor(BuildContext context) {
  return themeColors[getThemeColorKey(context)];
}

String getThemeColorKey(BuildContext context) {
  return context.watch<ThemeProvider>().themeColor;
}
