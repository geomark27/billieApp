/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: theme_provider
*/

import 'package:flutter/foundation.dart';
import 'package:salepro/constants/theme_appearence.dart';
import 'package:salepro/constants/theme_colors.dart';
import 'package:salepro/constants/theme_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _themeColor = 'indigo';
  String _themeFont = 'cabin';
  String _themeAppearence = 'system';
  bool _isLoading = false;

  String get themeColor => _themeColor;
  String get themeFont => _themeFont;
  String get themeAppearence => _themeAppearence;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> changeThemeColor(String newColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_COLOR, newColor);

    _themeColor = newColor;
    notifyListeners();
  }

  Future<void> changeThemeFont(String newFont) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_FONT, newFont);

    _themeFont = newFont;
    notifyListeners();
  }

  Future<void> changeThemeAppearence(String newAppearence) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_APPEARANCE, newAppearence);

    _themeAppearence = newAppearence;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      StringProperty(
        'themeColor',
        themeColor,
      ),
    );
    properties.add(
      StringProperty(
        'themeFont',
        themeFont,
      ),
    );
    properties.add(
      StringProperty('themeAppearence', themeAppearence),
    );
    properties.add(
      StringProperty('isLoading', isLoading.toString()),
    );
  }
}
