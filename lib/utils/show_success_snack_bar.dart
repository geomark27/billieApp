/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: show_success_snack_bar
*/

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_theme_font.dart';

showSnackBar(message, BuildContext context, {type = "success"}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: type == "success" ? 'Success!' : "Error!",
      message: message,
      contentType:
          type == "success" ? ContentType.success : ContentType.failure,
      titleTextStyle: TextStyle(
        fontSize: AppSpacing.kDefaultPadding * 2.5,
        color: type == "success"
            ? AppColors.greenSwatch.shade100
            : AppColors.roseSwatch.shade100,
        fontFamily: GoogleFonts.dynalight().fontFamily,
      ),
      messageTextStyle: TextStyle(
        fontSize: AppSpacing.kDefaultPadding,
        fontFamily: getThemeFont(context, type: "read"),
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
