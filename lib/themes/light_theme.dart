/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: light_theme
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salepro/constants/spacing.dart';

ThemeData lightTheme(
    {MaterialColor? color = AppColors.indigoSwatch, String? font}) {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: color?.shade100,
    primarySwatch: color,
    appBarTheme: AppBarTheme(
      foregroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppSpacing.kDefaultPadding * 1.2,
        fontFamily: font,
      ),
      centerTitle: false,
    ),
    fontFamily: font ?? GoogleFonts.cabin().fontFamily,
    useMaterial3: false,
  );
}
