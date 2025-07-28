/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_data
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/widgets/button.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form.dart';

class ImportData extends StatelessWidget {
  const ImportData({
    super.key,
    this.prefix,
    this.suffix,
    this.controller,
    this.fileLink,
  });

  final List<Widget>? prefix;
  final List<Widget>? suffix;
  final TextEditingController? controller;
  final String? fileLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: generateInputGroups([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Column(
            children: prefix!,
          ),
        ),
        AppFilePicker(
          hintText: "Upload CSV File",
          allowMultiple: false,
          controller: controller,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sample File",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding,
                ),
              ),
              const SizedBox(
                height: AppSpacing.kDefaultPadding,
              ),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  title: "Download",
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.download,
                  ),
                  bgColor: getThemeColor(context),
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        ...?suffix,
      ]),
    );
  }
}
