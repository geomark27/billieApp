/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: theme_colors
*/

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:salepro/constants/colors.dart';

const THEME_COLOR = 'salepro_theme_color';

final Map<String, MaterialColor> themeColors = {
  'blue': AppColors.blueSwatch,
  'indigo': AppColors.indigoSwatch,
  'purple': AppColors.purpleSwatch,
  'green': AppColors.greenSwatch,
  'orange': AppColors.orangeSwatch,
  'rose': AppColors.roseSwatch,
};

final Map<String, Map<String, String>> themeLogos = {
  'blue': {
    'light': "assets/images/logos/logo-blue.png",
    'dark': "assets/images/logos/logo-light.png"
  },
  'indigo': {
    'light': "assets/images/logos/logo-indigo.png",
    'dark': "assets/images/logos/logo-light.png"
  },
  'purple': {
    'light': "assets/images/logos/logo-purple.png",
    'dark': "assets/images/logos/logo-light.png"
  },
  'green': {
    'light': "assets/images/logos/logo-green.png",
    'dark': "assets/images/logos/logo-light.png"
  },
  'orange': {
    'light': "assets/images/logos/logo-orange.png",
    'dark': "assets/images/logos/logo-light.png"
  },
  'rose': {
    'light': "assets/images/logos/logo-rose.png",
    'dark': "assets/images/logos/logo-light.png"
  },
};
