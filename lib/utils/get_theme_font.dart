/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: get_theme_font
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/theme_fonts.dart';
import 'package:salepro/providers/theme_provider.dart';

String? getThemeFont(BuildContext context, {type = 'watch'}) {
  return themeFonts[getThemeFontKey(context, type: type)];
}

String getThemeFontKey(BuildContext context, {type = 'watch'}) {
  if (type == 'watch') {
    return context.watch<ThemeProvider>().themeFont;
  } else {
    return context.read<ThemeProvider>().themeFont;
  }
}
