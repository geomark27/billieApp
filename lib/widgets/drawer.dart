/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: drawer
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/nav_links.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/utils/get_app_logo.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/is_dark.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: useThemeMode(
              context,
              light: [
                getThemeColor(context)!.shade200,
                getThemeColor(context)!.shade200.withValues(alpha: 0.8)
              ],
              dark: [
                getThemeColor(context)!.shade800.withValues(alpha: 0.8),
                getThemeColor(context)!.shade900.withValues(alpha: 0.9),
              ],
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSpacing.kDefaultPadding * 2,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  AppSpacing.kDefaultPadding,
                ),
                child: Image.asset(
                  getAppLogo(context)!,
                  height: AppSpacing.kDefaultPadding * 3,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: navLinks.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == navLinks.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.kDefaultPadding * 2,
                        ),
                        child: DrawerCard(
                          navLink: navLinks[index],
                          type: "navlink",
                        ),
                      );
                    } else {
                      return DrawerCard(
                        navLink: navLinks[index],
                        type: "navlink",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    super.key,
    required this.navLink,
    required this.type,
  });

  final NavLink navLink;
  final String type;

  @override
  Widget build(BuildContext context) {
    switch (navLink.group) {
      case true:
        return ExpansionTile(
          visualDensity: type == "sublink" || type == "subsublink"
              ? const VisualDensity(vertical: VisualDensity.minimumDensity)
              : VisualDensity.compact,
          title: Text(
            navLink.title,
            style: TextStyle(
              fontSize: type == "sublink" || type == "subsublink"
                  ? AppSpacing.kDefaultPadding * 0.9
                  : AppSpacing.kDefaultPadding,
              fontWeight: type == "sublink" || type == "subsublink"
                  ? FontWeight.w400
                  : FontWeight.w700,
              color: useThemeMode(
                context,
                light: getThemeColor(context)!.shade900,
                dark: getThemeColor(context)!.shade100,
              ),
            ),
          ),
          leading: type == "sublink" || type == "subsublink"
              ? Padding(
                  padding: type == "subsublink"
                      ? const EdgeInsets.all(AppSpacing.kDefaultPadding)
                      : EdgeInsets.zero,
                )
              : DrawerIcon(
                  iconType: navLink.iconType,
                  icon: navLink.icon,
                ),
          children: navLink.links!
              .map(
                (link) => DrawerCard(
                  navLink: link,
                  type: type == "sublink" || type == "subsublink"
                      ? "subsublink"
                      : "sublink",
                ),
              )
              .toList(),
        );
      default:
        return ListTile(
          visualDensity: type == "sublink" || type == "subsublink"
              ? const VisualDensity(vertical: VisualDensity.minimumDensity)
              : VisualDensity.compact,
          onTap: navLink.onTap != null
              ? () {
                  navLink.onTap!(context);
                }
              : () {
                  if (navLink.path != null && navLink.screen == null) {
                    if (navLink.replaceScreen == false) {
                      Navigator.of(context).pushNamed(
                        navLink.path!,
                      );
                    } else {
                      Navigator.of(context).pushReplacementNamed(
                        navLink.path!,
                      );
                    }
                  } else if (navLink.path == null && navLink.screen != null) {
                    if (navLink.replaceScreen == false) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => navLink.screen!,
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => navLink.screen!,
                        ),
                      );
                    }
                  } else {}
                },
          title: Text(
            navLink.title,
            style: TextStyle(
              fontSize: type == "sublink" || type == "subsublink"
                  ? AppSpacing.kDefaultPadding * 0.9
                  : AppSpacing.kDefaultPadding,
              fontWeight: type == "sublink" || type == "subsublink"
                  ? FontWeight.w600
                  : FontWeight.w700,
              color: useThemeMode(
                context,
                light: type == "sublink" || type == "subsublink"
                    ? getThemeColor(context)!.shade900.withValues(alpha: 0.7)
                    : getThemeColor(context)!.shade900,
                dark: type == "sublink" || type == "subsublink"
                    ? getThemeColor(context)!.shade100.withValues(alpha: 0.7)
                    : getThemeColor(context)!.shade100,
              ),
            ),
          ),
          leading: type == "sublink" || type == "subsublink"
              ? Padding(
                  padding: type == "subsublink"
                      ? const EdgeInsets.all(AppSpacing.kDefaultPadding * 2)
                      : EdgeInsets.zero,
                )
              : DrawerIcon(
                  iconType: navLink.iconType,
                  icon: navLink.icon,
                ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: AppSpacing.kDefaultPadding,
          ),
        );
    }
  }
}

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key, required this.iconType, this.icon});
  final String iconType;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    switch (iconType) {
      case NavLink.heroIcon:
        return HeroIcon(
          icon,
          color: useThemeMode(
            context,
            dark: getThemeColor(context)!.shade100,
            light: getThemeColor(context)!.shade900,
          ),
          size: AppSpacing.kDefaultPadding * 2,
        );
      case NavLink.fontAwesomeIcon:
        return Padding(
          padding: const EdgeInsets.all(
            AppSpacing.kDefaultPadding * 0.2,
          ),
          child: Icon(
            icon,
            color: useThemeMode(
              context,
              dark: getThemeColor(context)!.shade100,
              light: getThemeColor(context)!.shade900,
            ),
            size: AppSpacing.kDefaultPadding * 1.7,
          ),
        );
      default:
        return Icon(
          icon,
          color: useThemeMode(
            context,
            light: getThemeColor(context)!.shade900,
            dark: getThemeColor(context)!.shade100,
          ),
          size: AppSpacing.kDefaultPadding * 2,
        );
    }
  }
}
