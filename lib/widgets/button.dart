/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: button
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.title,
    this.textColor,
    this.bgColor,
    this.icon,
  });

  final void Function()? onPressed;
  final String title;
  final Color? textColor;
  final Color? bgColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.kDefaultPadding * 3,
          vertical: AppSpacing.kDefaultPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.kDefaultPadding,
          ),
        ),
      ),
      icon: icon,
      label: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.slateSwatch,
          fontSize: AppSpacing.kDefaultPadding * 1.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
