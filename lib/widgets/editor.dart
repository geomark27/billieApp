/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: editor
*/

import 'package:flutter/material.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';

class Editor extends StatelessWidget {
  const Editor(
      {super.key,
      required this.controller,
      required this.label,
      this.errorLine});

  final QuillEditorController controller;
  final String label;
  final String? errorLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppSpacing.kDefaultPadding * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding,
              fontFamily: getThemeFont(context),
              fontWeight: FontWeight.bold,
              color: useThemeMode(
                context,
                light: getThemeColor(context)?.shade900,
                dark: getThemeColor(context)?.shade100,
              ),
            ),
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding * 0.5,
          ),
          ToolBar(
            toolBarColor: useThemeMode(
              context,
              light: AppColors.white,
              dark: AppColors.slateSwatch,
            ),
            iconColor: useThemeMode(
              context,
              light: AppColors.slateSwatch,
              dark: AppColors.white,
            ),
            activeIconColor: getThemeColor(context)?.shade500,
            padding: const EdgeInsets.all(8),
            iconSize: 20,
            controller: controller,
          ),
          QuillHtmlEditor(
            isEnabled: true,
            backgroundColor: useThemeMode(
              context,
              light: AppColors.white,
              dark: AppColors.slateSwatch,
            ),
            textStyle: TextStyle(
              color: useThemeMode(
                context,
                light: AppColors.slateSwatch,
                dark: AppColors.white,
              ),
              fontSize: AppSpacing.kDefaultPadding,
              fontWeight: FontWeight.normal,
              fontFamily: getThemeFont(context),
            ),
            controller: controller,
            minHeight: AppSpacing.kDefaultPadding * 20,
          ),
          if (errorLine != null)
            Container(
              padding: const EdgeInsets.only(
                left: AppSpacing.kDefaultPadding * 1.5,
                right: AppSpacing.kDefaultPadding * 1.5,
                top: AppSpacing.kDefaultPadding * 0.5,
              ),
              width: double.infinity,
              child: Text(
                errorLine!,
                textAlign: TextAlign.left,
                maxLines: 5,
                style: TextStyle(
                  color: AppColors.roseSwatch.shade600,
                  fontSize: AppSpacing.kDefaultPadding * 0.8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
