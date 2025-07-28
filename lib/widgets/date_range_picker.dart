/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: date_range_picker
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';

class AppDateRangePicker extends StatefulWidget {
  const AppDateRangePicker({
    super.key,
    required this.hintText,
    this.prefix,
    this.icon,
    this.controller,
    this.info,
    this.showInfoIcon = true,
    this.onChanged,
    this.fancy = false,
    this.value,
    this.startingDate,
    this.endingDate,
    this.errorLine,
  });

  final String hintText;
  final Widget? prefix;
  final HeroIcons? icon;
  final TextEditingController? controller;
  final String? info;
  final bool showInfoIcon;
  final DateTime? value;
  final DateTime? startingDate;
  final DateTime? endingDate;
  final void Function(DateTime, DateTime)? onChanged;
  final bool fancy;
  final List? errorLine;

  @override
  State<AppDateRangePicker> createState() => _AppDateRangePickerState();
}

class _AppDateRangePickerState extends State<AppDateRangePicker> {
  bool isLoading = false;
  bool selected = false;

  Future<void> pickDate() async {
    widget.controller?.text = "Loading...";
    setState(() {
      isLoading = true;
    });

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.kDefaultPadding,
              ),
              child: Text(
                "Select Date Range",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: AppSpacing.kDefaultPadding * 0.5,
            ),
            ListTile(
              onTap: () {
                final now = DateTime.now();
                final start = DateTime(now.year, now.month - 1, now.day);

                widget.controller?.text =
                    "${DateFormat('dd MMMM, yyyy').format(start)} - ${DateFormat('dd MMMM, yyyy').format(now)}";
                setState(() {
                  isLoading = false;
                  selected = true;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    start,
                    now,
                  );
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              visualDensity: VisualDensity.compact,
              title: Text(
                "Last 30 Days",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: useThemeMode(
                    context,
                    light: AppColors.slateSwatch.shade600,
                    dark: AppColors.slateSwatch.shade400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                final now = DateTime.now();
                final start = DateTime(now.year, now.month - 3, now.day);

                widget.controller?.text =
                    "${DateFormat('dd MMMM, yyyy').format(start)} - ${DateFormat('dd MMMM, yyyy').format(now)}";
                setState(() {
                  isLoading = false;
                  selected = true;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    start,
                    now,
                  );
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              visualDensity: VisualDensity.compact,
              title: Text(
                "Last 90 Days",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: useThemeMode(
                    context,
                    light: AppColors.slateSwatch.shade600,
                    dark: AppColors.slateSwatch.shade400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                final now = DateTime.now();
                final start = DateTime(now.year - 1, now.month, now.day);

                widget.controller?.text =
                    "${DateFormat('dd MMMM, yyyy').format(start)} - ${DateFormat('dd MMMM, yyyy').format(now)}";
                setState(() {
                  isLoading = false;
                  selected = true;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    start,
                    now,
                  );
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              visualDensity: VisualDensity.compact,
              title: Text(
                "Last Year",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: useThemeMode(
                    context,
                    light: AppColors.slateSwatch.shade600,
                    dark: AppColors.slateSwatch.shade400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                final now = DateTime.now();
                final start = DateTime(1995, now.month, now.day);

                widget.controller?.text =
                    "${DateFormat('dd MMMM, yyyy').format(start)} - ${DateFormat('dd MMMM, yyyy').format(now)}";
                setState(() {
                  isLoading = false;
                  selected = true;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    start,
                    now,
                  );
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              visualDensity: VisualDensity.compact,
              title: Text(
                "All Time",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: useThemeMode(
                    context,
                    light: AppColors.slateSwatch.shade600,
                    dark: AppColors.slateSwatch.shade400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                final DateTimeRange? pickedRange = await showDateRangePicker(
                  context: context,
                  firstDate: widget.startingDate ?? DateTime(1995),
                  lastDate: widget.endingDate ?? DateTime.now(),
                );

                if (pickedRange != null) {
                  widget.controller?.text =
                      "${DateFormat('dd MMMM, yyyy').format(pickedRange.start)} - ${DateFormat('dd MMMM, yyyy').format(pickedRange.end)}";
                  setState(() {
                    isLoading = false;
                    selected = true;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(pickedRange.start, pickedRange.end);
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  setState(() {
                    isLoading = false;
                    widget.controller?.text = "";
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  return;
                }
              },
              visualDensity: VisualDensity.compact,
              title: Text(
                "Custom Range",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: useThemeMode(
                    context,
                    light: AppColors.slateSwatch.shade600,
                    dark: AppColors.slateSwatch.shade400,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (!isLoading) {
                      await pickDate();
                    }
                  },
                  child: TextField(
                    readOnly: true,
                    enabled: false,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: widget.fancy
                            ? AppSpacing.kDefaultPadding
                            : AppSpacing.kDefaultPadding * 0.5,
                        horizontal: AppSpacing.kDefaultPadding,
                      ),
                      label: widget.fancy ? null : Text(widget.hintText),
                      hintText: "Select Date Range",
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
                      prefixIcon: widget.icon == null &&
                              widget.prefix == null &&
                              !isLoading
                          ? null
                          : isLoading
                              ? const SizedBox(
                                  width: AppSpacing.kDefaultPadding * 0.5,
                                  height: AppSpacing.kDefaultPadding * 0.5,
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    right: widget.icon == null &&
                                            widget.prefix == null &&
                                            !isLoading
                                        ? 0
                                        : AppSpacing.kDefaultPadding * 0.5,
                                  ),
                                  child: widget.prefix == null
                                      ? widget.icon != null
                                          ? HeroIcon(
                                              widget.icon!,
                                              style: HeroIconStyle.solid,
                                              size: AppSpacing.kDefaultPadding *
                                                  1.6,
                                            )
                                          : const SizedBox(
                                              width: 0,
                                            )
                                      : widget.prefix!,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.kDefaultPadding * 0.5,
                ),
                child: inputIcons(context),
              ),
            ],
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
    return widget.info != null && widget.showInfoIcon
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
                light: getThemeColor(context)?.shade800.withValues(alpha: 0.7),
                dark: getThemeColor(context)?.shade200.withValues(alpha: 0.7),
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
