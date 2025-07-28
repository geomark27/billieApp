/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: select
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';

class AppSelect extends StatelessWidget {
  const AppSelect({
    super.key,
    required this.hintText,
    this.prefix,
    this.icon,
    this.info,
    this.showInfoIcon = true,
    this.actionIcon = HeroIcons.plusCircle,
    this.actionIconProvider = InputIcon.heroIcon,
    this.onAction,
    this.screenToOpenOnSuffixTap,
    this.enableFilter = true,
    this.enableSearch = true,
    required this.items,
    required this.onChange,
    this.value,
    this.fancy = false,
    this.errorLine,
  });

  final String hintText;
  final Widget? prefix;
  final HeroIcons? icon;
  final String? info;
  final bool showInfoIcon;
  final dynamic actionIcon;
  final String actionIconProvider;
  final VoidCallback? onAction;
  final Widget? screenToOpenOnSuffixTap;
  final bool enableFilter;
  final bool enableSearch;
  final List<Map<String, dynamic>> items;
  final String? value;
  final void Function(String? value) onChange;
  final bool fancy;
  final List? errorLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.8,
            vertical: AppSpacing.kDefaultPadding * 0.3,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: useThemeMode(
                context,
                light: getThemeColor(context)?.shade800.withValues(alpha: 0.5),
                dark: getThemeColor(context)?.shade100.withValues(alpha: 0.5),
              ),
            ),
            color: useThemeMode(
              context,
              light: fancy
                  ? getThemeColor(context)?.shade100.withValues(alpha: 0.9)
                  : getThemeColor(context)?.shade200.withValues(alpha: 0.5),
              dark: fancy
                  ? getThemeColor(context)?.shade900.withValues(alpha: 0.9)
                  : getThemeColor(context)?.shade900.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(AppSpacing.kDefaultPadding),
            boxShadow: fancy
                ? [
                    BoxShadow(
                      color: useThemeMode(
                        context,
                        light: getThemeColor(context)
                            ?.shade100
                            .withValues(alpha: 0.25),
                        dark: getThemeColor(context)
                            ?.shade900
                            .withValues(alpha: 0.5),
                      ),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                flex: showInfoIcon &&
                        info != null &&
                        (onAction != null || screenToOpenOnSuffixTap != null)
                    ? 3
                    : 6,
                child: DropdownMenu(
                  initialSelection: value,
                  menuHeight: getScreenSize(context) * 0.7,
                  onSelected: (data) {
                    onChange('$data');
                  },
                  enableFilter: enableFilter,
                  enableSearch: enableSearch,
                  searchCallback: enableSearch
                      ? (entries, String query) {
                          if (query.isEmpty) {
                            return null;
                          }

                          final int index = entries.indexWhere(
                            (entry) => entry.label.toLowerCase().contains(
                                  query.trim().toLowerCase(),
                                ),
                          );

                          return index != -1 ? index : null;
                        }
                      : null,
                  filterCallback: enableFilter
                      ? (entries, String filter) {
                          final String trimmedFilter =
                              filter.trim().toLowerCase();
                          if (trimmedFilter.isEmpty) {
                            return entries;
                          }
                          return entries
                              .where(
                                (entry) => entry.label
                                    .toLowerCase()
                                    .contains(trimmedFilter),
                              )
                              .toList();
                        }
                      : null,
                  width: getScreenSize(context, type: 'width') -
                      AppSpacing.kDefaultPadding * 3.5,
                  textStyle: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding,
                    fontFamily: getThemeFont(context),
                  ),
                  menuStyle: MenuStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    visualDensity: VisualDensity.comfortable,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.kDefaultPadding * 0.5,
                        ),
                      ),
                    ),
                  ),
                  hintText: "Select $hintText",
                  label: fancy ? null : Text(hintText),
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: fancy
                          ? AppSpacing.kDefaultPadding
                          : AppSpacing.kDefaultPadding * 0.5,
                      horizontal: AppSpacing.kDefaultPadding,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AppSpacing.kDefaultPadding,
                      fontFamily: getThemeFont(context),
                      color: useThemeMode(
                        context,
                        light: getThemeColor(context)?.shade900,
                        dark: getThemeColor(context)?.shade100,
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: AppSpacing.kDefaultPadding,
                      fontFamily: getThemeFont(context),
                      color: useThemeMode(
                        context,
                        light: getThemeColor(context)
                            ?.shade900
                            .withValues(alpha: 0.6),
                        dark: getThemeColor(context)
                            ?.shade100
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    prefixIconColor: useThemeMode(
                      context,
                      light: getThemeColor(context)
                          ?.shade800
                          .withValues(alpha: 0.6),
                      dark: getThemeColor(context)
                          ?.shade200
                          .withValues(alpha: 0.6),
                    ),
                    suffixIconColor: useThemeMode(
                      context,
                      light: getThemeColor(context)
                          ?.shade800
                          .withValues(alpha: 0.7),
                      dark: getThemeColor(context)
                          ?.shade200
                          .withValues(alpha: 0.7),
                    ),
                    border: InputBorder.none,
                  ),
                  dropdownMenuEntries: items.isNotEmpty
                      ? items
                          .map(
                            (item) => DropdownMenuEntry(
                              value: item['value']!,
                              label: item['label']!,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.kDefaultPadding * 2,
                                ),
                                textStyle: TextStyle(
                                  fontSize: AppSpacing.kDefaultPadding,
                                  fontFamily: getThemeFont(context),
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : [
                          DropdownMenuEntry(
                            label: "No Item Selected",
                            value: "null",
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.kDefaultPadding * 2,
                              ),
                              textStyle: TextStyle(
                                fontSize: AppSpacing.kDefaultPadding,
                                fontFamily: getThemeFont(context),
                              ),
                            ),
                            enabled: false,
                          ),
                        ],
                  leadingIcon: icon == null && prefix == null
                      ? null
                      : Padding(
                          padding: EdgeInsets.only(
                            right: icon == null && prefix == null
                                ? 0
                                : AppSpacing.kDefaultPadding * 0.5,
                          ),
                          child: prefix == null
                              ? icon != null
                                  ? HeroIcon(
                                      icon!,
                                      style: HeroIconStyle.solid,
                                      size: AppSpacing.kDefaultPadding * 1.6,
                                    )
                                  : const SizedBox(
                                      width: 0,
                                    )
                              : prefix!,
                        ),
                  trailingIcon: const SizedBox(
                    width: 0,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: onAction != null || screenToOpenOnSuffixTap != null
                    ? FittedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            inputIcons(context),
                            IconButton(
                              onPressed: () {
                                if (onAction != null &&
                                    screenToOpenOnSuffixTap != null) {
                                  onAction!();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          screenToOpenOnSuffixTap!,
                                    ),
                                  );
                                } else if (onAction != null &&
                                    screenToOpenOnSuffixTap == null) {
                                  onAction!();
                                } else if (onAction == null &&
                                    screenToOpenOnSuffixTap != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          screenToOpenOnSuffixTap!,
                                    ),
                                  );
                                }
                              },
                              icon: InputIcon(
                                iconType: actionIconProvider,
                                icon: actionIcon,
                              ),
                            ),
                          ],
                        ),
                      )
                    : inputIcons(context),
              ),
            ],
          ),
        ),
        if (info != null && !showInfoIcon)
          Container(
            padding: const EdgeInsets.only(
              left: AppSpacing.kDefaultPadding * 1.5,
              right: AppSpacing.kDefaultPadding * 1.5,
              top: AppSpacing.kDefaultPadding * 0.5,
            ),
            width: double.infinity,
            child: Text(
              info!,
              textAlign: TextAlign.left,
              maxLines: 5,
              style: TextStyle(
                color: useThemeMode(
                  context,
                  light: getThemeColor(context)?.shade900,
                  dark: getThemeColor(context)?.shade100,
                ),
                fontSize: AppSpacing.kDefaultPadding * 0.8,
              ),
            ),
          ),
        if (errorLine != null)
          Container(
            padding: const EdgeInsets.only(
              left: AppSpacing.kDefaultPadding * 1.5,
              right: AppSpacing.kDefaultPadding * 1.5,
              top: AppSpacing.kDefaultPadding * 0.5,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: errorLine!
                  .map(
                    (e) => Text(
                      e.toString(),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                      style: TextStyle(
                        color: AppColors.roseSwatch.shade600,
                        fontSize: AppSpacing.kDefaultPadding * 0.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget inputIcons(BuildContext context) {
    return info != null && showInfoIcon
        ? IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: useThemeMode(
                      context,
                      light: getThemeColor(context)?.shade100,
                      dark: getThemeColor(context)
                          ?.shade900
                          .withValues(alpha: 0.1),
                    ),
                    height: info!.length < 100
                        ? getScreenSize(context) * 0.2
                        : getScreenSize(context) * 0.4,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.kDefaultPadding,
                      vertical: AppSpacing.kDefaultPadding,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HeroIcon(
                            HeroIcons.informationCircle,
                            size: AppSpacing.kDefaultPadding * 3,
                            color: useThemeMode(
                              context,
                              light: getThemeColor(context)?.shade900,
                              dark: getThemeColor(context)?.shade100,
                            ),
                          ),
                          Text(
                            info!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: useThemeMode(
                                context,
                                light: getThemeColor(context)?.shade900,
                                dark: getThemeColor(context)?.shade100,
                              ),
                              fontSize: AppSpacing.kDefaultPadding * 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: HeroIcon(
              HeroIcons.questionMarkCircle,
              style: HeroIconStyle.outline,
              color: useThemeMode(
                context,
                light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
                dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
              ),
              size: AppSpacing.kDefaultPadding * 2.5,
            ),
          )
        : const SizedBox(
            width: 0,
            height: 0,
          );
  }
}

class InputIcon extends StatelessWidget {
  const InputIcon({super.key, required this.iconType, this.icon});
  final String iconType;
  final dynamic icon;

  static const heroIcon = "heroicon";
  static const fontAwesomeIcon = "fontawesomeicon";
  static const materialIcon = "materialicon";

  @override
  Widget build(BuildContext context) {
    switch (iconType) {
      case InputIcon.heroIcon:
        return HeroIcon(
          icon,
          color: useThemeMode(
            context,
            light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
            dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
          ),
          size: AppSpacing.kDefaultPadding * 2,
        );
      case InputIcon.fontAwesomeIcon:
        return Padding(
          padding: const EdgeInsets.all(
            AppSpacing.kDefaultPadding * 0.2,
          ),
          child: Icon(
            icon,
            color: useThemeMode(
              context,
              light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
              dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
            ),
            size: AppSpacing.kDefaultPadding * 1.5,
          ),
        );
      default:
        return Icon(
          icon,
          color: useThemeMode(
            context,
            light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
            dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
          ),
          size: AppSpacing.kDefaultPadding * 1.7,
        );
    }
  }
}
