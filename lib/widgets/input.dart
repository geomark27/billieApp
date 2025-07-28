/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: input
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    required this.hintText,
    this.prefix,
    this.icon,
    this.password = false,
    this.showPasswordShowIcon = true,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.readOnly = false,
    this.info,
    this.showInfoIcon = true,
    this.actionIcon = HeroIcons.plusCircle,
    this.actionIconProvider = InputIcon.heroIcon,
    this.onAction,
    this.screenToOpenOnSuffixTap,
    this.fancy = false,
    this.multiline = false,
    this.placeholder,
    this.errorLine,
    this.action = TextInputAction.next,
    this.onChanged,
  });

  final String hintText;
  final Widget? prefix;
  final HeroIcons? icon;
  final bool password;
  final bool showPasswordShowIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final String? info;
  final bool showInfoIcon;
  final dynamic actionIcon;
  final String actionIconProvider;
  final VoidCallback? onAction;
  final Widget? screenToOpenOnSuffixTap;
  final bool fancy;
  final bool multiline;
  final String? placeholder;
  final List? errorLine;
  final TextInputAction action;
  final void Function(String)? onChanged;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              light: widget.fancy
                  ? getThemeColor(context)?.shade100.withValues(alpha: 0.9)
                  : getThemeColor(context)?.shade200.withValues(alpha: 0.5),
              dark: widget.fancy
                  ? getThemeColor(context)?.shade900.withValues(alpha: 0.9)
                  : getThemeColor(context)?.shade900.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(AppSpacing.kDefaultPadding),
            boxShadow: widget.fancy
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
          child: TextField(
            onChanged: widget.onChanged,
            minLines: widget.multiline ? 5 : 1,
            maxLines: widget.multiline ? 10 : 1,
            readOnly: widget.readOnly,
            enabled: !widget.readOnly,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.password ? obscureText : false,
            textInputAction: widget.action,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.fancy
                    ? AppSpacing.kDefaultPadding
                    : AppSpacing.kDefaultPadding * 0.5,
                horizontal: AppSpacing.kDefaultPadding,
              ),
              labelText: !widget.fancy ? widget.hintText : null,
              labelStyle: TextStyle(
                fontSize: AppSpacing.kDefaultPadding,
                fontFamily: getThemeFont(context),
                color: useThemeMode(
                  context,
                  light: widget.errorLine != null
                      ? AppColors.roseSwatch
                      : getThemeColor(context)?.shade900,
                  dark: widget.errorLine != null
                      ? AppColors.roseSwatch.shade400
                      : getThemeColor(context)?.shade100,
                ),
              ),
              hintText: widget.placeholder ?? "Enter ${widget.hintText}",
              hintStyle: TextStyle(
                fontSize: AppSpacing.kDefaultPadding,
                fontFamily: getThemeFont(context),
                color: useThemeMode(
                  context,
                  light: widget.errorLine != null
                      ? AppColors.roseSwatch
                      : getThemeColor(context)?.shade900.withValues(alpha: 0.6),
                  dark: widget.errorLine != null
                      ? AppColors.roseSwatch.shade400
                      : getThemeColor(context)?.shade100.withValues(alpha: 0.6),
                ),
              ),
              prefixIconColor: useThemeMode(
                context,
                light: widget.errorLine != null
                    ? AppColors.roseSwatch
                    : getThemeColor(context)?.shade800.withValues(alpha: 0.6),
                dark: widget.errorLine != null
                    ? AppColors.roseSwatch.shade400
                    : getThemeColor(context)?.shade200.withValues(alpha: 0.6),
              ),
              prefixIcon: widget.icon == null && widget.prefix == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(
                        right: widget.icon == null && widget.prefix == null
                            ? 0
                            : AppSpacing.kDefaultPadding * 0.5,
                      ),
                      child: widget.prefix == null
                          ? widget.icon != null
                              ? HeroIcon(
                                  widget.icon!,
                                  style: HeroIconStyle.solid,
                                  size: AppSpacing.kDefaultPadding * 1.6,
                                )
                              : const SizedBox(
                                  width: 0,
                                )
                          : widget.prefix!,
                    ),
              suffixIconColor: useThemeMode(
                context,
                light: widget.errorLine != null
                    ? AppColors.roseSwatch
                    : getThemeColor(context)?.shade800.withValues(alpha: 0.7),
                dark: widget.errorLine != null
                    ? AppColors.roseSwatch.shade400
                    : getThemeColor(context)?.shade200.withValues(alpha: 0.7),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.kDefaultPadding * 0.5,
                ),
                child: widget.onAction != null ||
                        widget.screenToOpenOnSuffixTap != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          inputIcons(context),
                          const SizedBox(
                            width: AppSpacing.kDefaultPadding * 0.5,
                          ),
                          IconButton(
                            onPressed: () {
                              if (widget.onAction != null &&
                                  widget.screenToOpenOnSuffixTap != null) {
                                widget.onAction!();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        widget.screenToOpenOnSuffixTap!,
                                  ),
                                );
                              } else if (widget.onAction != null &&
                                  widget.screenToOpenOnSuffixTap == null) {
                                widget.onAction!();
                              } else if (widget.onAction == null &&
                                  widget.screenToOpenOnSuffixTap != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        widget.screenToOpenOnSuffixTap!,
                                  ),
                                );
                              }
                            },
                            icon: InputIcon(
                              iconType: widget.actionIconProvider,
                              icon: widget.actionIcon,
                            ),
                          ),
                        ],
                      )
                    : inputIcons(context),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        if (widget.info != null && !widget.showInfoIcon)
          Container(
            padding: const EdgeInsets.only(
              left: AppSpacing.kDefaultPadding * 1.5,
              right: AppSpacing.kDefaultPadding * 1.5,
              top: AppSpacing.kDefaultPadding * 0.5,
            ),
            width: double.infinity,
            child: Text(
              widget.info!,
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
        if (widget.errorLine != null)
          Container(
            padding: const EdgeInsets.only(
              left: AppSpacing.kDefaultPadding * 1.5,
              right: AppSpacing.kDefaultPadding * 1.5,
              top: AppSpacing.kDefaultPadding * 0.5,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.errorLine!
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
    return widget.password && widget.showPasswordShowIcon
        ? IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: HeroIcon(
              obscureText ? HeroIcons.eye : HeroIcons.eyeSlash,
              style: HeroIconStyle.solid,
              color: useThemeMode(
                context,
                light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
                dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
              ),
              size: AppSpacing.kDefaultPadding * 1.5,
            ),
          )
        : widget.info != null && widget.showInfoIcon
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
                        height: widget.info!.length < 100
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
                              const SizedBox(
                                height: AppSpacing.kDefaultPadding * 0.5,
                              ),
                              Text(
                                widget.info!,
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
                    light:
                        getThemeColor(context)?.shade800.withValues(alpha: 0.7),
                    dark:
                        getThemeColor(context)?.shade200.withValues(alpha: 0.7),
                  ),
                  size: AppSpacing.kDefaultPadding * 1.2,
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
          size: AppSpacing.kDefaultPadding * 1.5,
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
            size: AppSpacing.kDefaultPadding * 1.3,
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
          size: AppSpacing.kDefaultPadding * 1.5,
        );
    }
  }
}
