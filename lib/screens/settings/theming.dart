/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: theming
*/

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/constants/theme_colors.dart';
import 'package:salepro/constants/theme_fonts.dart';
import 'package:salepro/providers/theme_provider.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/drawer.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(
          AppSpacing.kDefaultPadding * 1.5,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appearance",
              style: TextStyle(
                fontSize: AppSpacing.kDefaultPadding * 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: AppSpacing.kDefaultPadding,
            ),
            SizedBox(
              height: AppSpacing.kDefaultPadding * 4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SystemApperanceBox(),
                  LightApperanceBox(),
                  DarkAppearanceBox(),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.kDefaultPadding * 2,
            ),
            const Text(
              "Theme",
              style: TextStyle(
                fontSize: AppSpacing.kDefaultPadding * 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: AppSpacing.kDefaultPadding,
            ),
            const ThemeWidget(),
            const SizedBox(
              height: AppSpacing.kDefaultPadding * 2,
            ),
            const Text(
              "Fonts",
              style: TextStyle(
                fontSize: AppSpacing.kDefaultPadding * 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: AppSpacing.kDefaultPadding,
            ),
            const FontsWidget(),
          ],
        ),
      ),
    );
  }
}

class FontsWidget extends StatelessWidget {
  const FontsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.kDefaultPadding * 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: themeFonts.length,
        itemBuilder: (context, index) {
          final value = themeFonts.values.toList()[index];
          final key = themeFonts.keys.toList()[index];

          return GestureDetector(
            onTap: () {
              context.read<ThemeProvider>().changeThemeFont(key);
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 800,
              ),
              decoration: BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    width:
                        context.watch<ThemeProvider>().themeFont == key ? 3 : 0,
                    color: getThemeColor(context)!.shade500,
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    context.watch<ThemeProvider>().themeFont == key
                        ? AppSpacing.kDefaultPadding * 0.8
                        : AppSpacing.kDefaultPadding * 0.5,
                  ),
                ),
                color: context.watch<ThemeProvider>().themeFont == key
                    ? Colors.transparent
                    : getThemeColor(context)?.shade500.withValues(alpha: 0.1),
              ),
              margin: const EdgeInsets.only(
                right: AppSpacing.kDefaultPadding,
              ),
              width: AppSpacing.kDefaultPadding * 6,
              height: AppSpacing.kDefaultPadding * 2,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 800,
                ),
                opacity:
                    context.watch<ThemeProvider>().themeFont == key ? 1 : 0.7,
                child: Center(
                  child: FittedBox(
                    child: Text(
                      key,
                      style: TextStyle(
                        color: themeColors[
                                context.watch<ThemeProvider>().themeColor]!
                            .shade500,
                        fontSize: AppSpacing.kDefaultPadding,
                        fontFamily: value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({
    super.key,
  });

  Future<void> changeIcon(BuildContext context, String icon) async {
    try {
      if (await FlutterDynamicIconPlus.supportsAlternateIcons) {
        await FlutterDynamicIconPlus.setAlternateIconName(
          iconName: icon,
          blacklistBrands: ['Redmi'],
          blacklistManufactures: ['Xiaomi'],
          blacklistModels: ['Redmi 200A'],
        );

        showSnackBar(
          "Updated the theme successfully...",
          // ignore: use_build_context_synchronously
          context,
        );
        return;
      }
    } catch (_) {
      showSnackBar(
        "Couldn't update the app icon...",
        // ignore: use_build_context_synchronously
        context,
        type: "error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.kDefaultPadding * 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: themeColors.length,
        itemBuilder: (context, index) {
          final value = themeColors.values.toList()[index];
          final key = themeColors.keys.toList()[index];

          return GestureDetector(
            onTap: () {
              context.read<ThemeProvider>().changeThemeColor(key);
              changeIcon(context, key);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              decoration: BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    width: context.watch<ThemeProvider>().themeColor == key
                        ? 2
                        : 0,
                    color: value,
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    context.watch<ThemeProvider>().themeColor == key
                        ? AppSpacing.kDefaultPadding * 1.2
                        : AppSpacing.kDefaultPadding * 0.8,
                  ),
                ),
                color: context.watch<ThemeProvider>().themeColor == key
                    ? value.withValues(alpha: 0.75)
                    : value,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/icons/$key.png",
                  ),
                ),
              ),
              margin: const EdgeInsets.only(
                right: AppSpacing.kDefaultPadding,
              ),
              width: AppSpacing.kDefaultPadding * 4,
              height: AppSpacing.kDefaultPadding * 4,
            ),
          );
        },
      ),
    );
  }
}

class DarkAppearanceBox extends StatelessWidget {
  const DarkAppearanceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeProvider>().changeThemeAppearence('dark');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: Theme.of(context).brightness == Brightness.dark ? 3 : 0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Theme.of(context).brightness == Brightness.dark
                  ? AppSpacing.kDefaultPadding
                  : AppSpacing.kDefaultPadding * 0.5,
            ),
          ),
          color: AppColors.slateSwatch,
        ),
        margin: const EdgeInsets.only(
          right: AppSpacing.kDefaultPadding,
        ),
        width: AppSpacing.kDefaultPadding * 4,
        height: AppSpacing.kDefaultPadding * 4,
        child: AnimatedOpacity(
          opacity: Theme.of(context).brightness == Brightness.dark ? 1 : 0.5,
          duration: const Duration(milliseconds: 800),
          child: const Icon(
            Icons.dark_mode,
            color: AppColors.white,
            size: AppSpacing.kDefaultPadding * 2,
          ),
        ),
      ),
    );
  }
}

class LightApperanceBox extends StatelessWidget {
  const LightApperanceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeProvider>().changeThemeAppearence('light');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: Theme.of(context).brightness == Brightness.light ? 3 : 0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Theme.of(context).brightness == Brightness.light
                  ? AppSpacing.kDefaultPadding
                  : AppSpacing.kDefaultPadding * 0.5,
            ),
          ),
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(
          right: AppSpacing.kDefaultPadding,
        ),
        width: AppSpacing.kDefaultPadding * 4,
        height: AppSpacing.kDefaultPadding * 4,
        child: AnimatedOpacity(
          opacity: Theme.of(context).brightness == Brightness.light ? 1 : 0.5,
          duration: const Duration(milliseconds: 800),
          child: const Icon(
            Icons.sunny,
            color: AppColors.orangeSwatch,
            size: AppSpacing.kDefaultPadding * 2,
          ),
        ),
      ),
    );
  }
}

class SystemApperanceBox extends StatelessWidget {
  const SystemApperanceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeProvider>().changeThemeAppearence('system');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: context.watch<ThemeProvider>().themeAppearence == 'system'
                  ? 3
                  : 0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.watch<ThemeProvider>().themeAppearence == 'system'
                  ? AppSpacing.kDefaultPadding
                  : AppSpacing.kDefaultPadding * 0.5,
            ),
          ),
          color: getThemeColor(context),
        ),
        margin: const EdgeInsets.only(
          right: AppSpacing.kDefaultPadding,
        ),
        width: AppSpacing.kDefaultPadding * 4,
        height: AppSpacing.kDefaultPadding * 4,
        child: AnimatedOpacity(
          opacity: context.watch<ThemeProvider>().themeAppearence == 'system'
              ? 1
              : 0.5,
          duration: const Duration(milliseconds: 800),
          child: Icon(
            Icons.app_settings_alt,
            color: getThemeColor(context)!.shade50,
            size: AppSpacing.kDefaultPadding * 2,
          ),
        ),
      ),
    );
  }
}
