/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: main
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/theme_appearence.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/theme_colors.dart';
import 'package:salepro/constants/theme_fonts.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/providers/theme_provider.dart';
import 'package:salepro/screens/auth/welcome.dart';
import 'package:salepro/themes/dark_theme.dart';
import 'package:salepro/themes/light_theme.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CommonDataProvider()),
      ],
      child: const SaleProApp(),
    ),
  );
}

class SaleProApp extends StatefulWidget {
  const SaleProApp({super.key});

  @override
  State<SaleProApp> createState() => _SaleProAppState();
}

class _SaleProAppState extends State<SaleProApp> {
  @override
  void initState() {
    super.initState();

    fetchTheme(context);
    initializeOnesignal();
  }

  Future<void> fetchTheme(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String themeAppearance =
        prefs.getString(THEME_APPEARANCE) ?? 'system';
    final String themeColor = prefs.getString(THEME_COLOR) ?? 'indigo';
    final String themeFont = prefs.getString(THEME_FONT) ?? 'cabin';

    // ignore: use_build_context_synchronously
    context.read<ThemeProvider>().changeThemeAppearence(themeAppearance);
    // ignore: use_build_context_synchronously
    context.read<ThemeProvider>().changeThemeColor(themeColor);
    // ignore: use_build_context_synchronously
    context.read<ThemeProvider>().changeThemeFont(themeFont);
  }

  Future<void> initializeOnesignal() async {
    OneSignal.initialize("56d01fad-2269-4680-aec4-e6e67a67e364");
    await OneSignal.Notifications.requestPermission(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Salepro POS",
      home: const WelcomeScreen(),
      theme: lightTheme(
        color: getThemeColor(context),
        font: themeFonts[context.watch<ThemeProvider>().themeFont],
      ),
      darkTheme: darkTheme(
        color: getThemeColor(context),
        font: themeFonts[context.watch<ThemeProvider>().themeFont],
        bg: AppColors.darkBG[getThemeColorKey(context)],
      ),
      themeMode: themeApperance[context.watch<ThemeProvider>().themeAppearence],
    );
  }
}
