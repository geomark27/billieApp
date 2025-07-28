/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: dark_theme
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salepro/constants/spacing.dart';

ThemeData darkTheme({
  MaterialColor? color = AppColors.indigoSwatch,
  String? font,
  Color? bg,
}) {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    primarySwatch: color,
    primaryColor: color,
    appBarTheme: AppBarTheme(
      foregroundColor: AppColors.white,
      backgroundColor: color?.shade900.withValues(alpha: 0.9),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppSpacing.kDefaultPadding * 1.2,
        fontFamily: font,
      ),
      centerTitle: false,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: bg?.withValues(alpha: 0.2),
    ),
    fontFamily: font ?? GoogleFonts.cabin().fontFamily,
    useMaterial3: false,
  );
}
