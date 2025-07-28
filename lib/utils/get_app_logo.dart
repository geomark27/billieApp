/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: get_app_logo
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/theme_colors.dart';
import 'package:salepro/providers/theme_provider.dart';
import 'package:salepro/utils/is_dark.dart';

String? getAppLogo(BuildContext context) {
  return useThemeMode(
    context,
    light: themeLogos[context.watch<ThemeProvider>().themeColor]!["light"],
    dark: themeLogos[context.watch<ThemeProvider>().themeColor]!["dark"],
  );
}
