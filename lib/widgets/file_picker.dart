/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: file_picker
*/

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';

class AppFilePicker extends StatefulWidget {
  const AppFilePicker({
    super.key,
    required this.hintText,
    this.prefix,
    this.icon,
    this.controller,
    this.info,
    this.showInfoIcon = true,
    required this.allowMultiple,
    this.allowedExtensions,
    this.onChanged,
    this.fancy = false,
    this.errorLine,
  });

  final String hintText;
  final Widget? prefix;
  final HeroIcons? icon;
  final TextEditingController? controller;
  final String? info;
  final bool showInfoIcon;
  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final void Function(dynamic)? onChanged;
  final bool fancy;
  final List? errorLine;

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.text = "No file selected...";
  }

  Future<void> pickFile() async {
    widget.controller?.text = "Loading...";
    setState(() {
      isLoading = true;
    });

    if (widget.allowMultiple) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null) {
        widget.controller?.text = "Selected ${result.paths.length} files...";
        setState(() {
          isLoading = false;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(result.paths.map((path) => File(path!)).toList());
        }
      } else {
        widget.controller?.text = "No file selected...";
        setState(() {
          isLoading = false;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        widget.controller?.text = "Selected file: ${file.path}";
        setState(() {
          isLoading = false;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(file);
        }
      } else {
        widget.controller?.text = "No file selected...";
        setState(() {
          isLoading = false;
        });
      }
    }
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
                      await pickFile();
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
                      hintText: "Choose File",
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
