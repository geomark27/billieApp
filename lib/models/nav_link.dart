/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: nav_link
*/

import 'package:flutter/material.dart';

class NavLink {
  final String title;
  final dynamic icon;
  final String iconType;
  final bool group;
  final List<NavLink>? links;
  final Function(BuildContext context)? onTap;
  final String? path;
  final bool replaceScreen;
  final Widget? screen;

  static const String materialIcon = "materialicon";
  static const String fontAwesomeIcon = "fontawesome";
  static const String heroIcon = "heroicon";

  NavLink(
      {this.onTap,
      this.path,
      this.replaceScreen = false,
      required this.title,
      required this.icon,
      this.iconType = "materialicon",
      required this.group,
      this.screen,
      this.links});
}
