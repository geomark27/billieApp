/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: checkbox
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/text_button.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    required this.hintText,
    this.info,
    this.showInfoIcon = true,
    this.value = false,
    required this.onChanged,
    this.errorLine,
  });

  final String hintText;
  final String? info;
  final bool showInfoIcon;
  final bool value;
  final void Function(bool?)? onChanged;
  final List? errorLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: info != null && !showInfoIcon
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: getThemeColor(context),
          value: value,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.kDefaultPadding * 0.3,
            ),
          ),
        ),
        Expanded(
          child: AppTextButton(
            onTap: () {
              onChanged!(!value);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hintText,
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding,
                    fontFamily: getThemeFont(context),
                    fontWeight: FontWeight.w700,
                    color: useThemeMode(
                      context,
                      light: getThemeColor(context)?.shade900,
                      dark: getThemeColor(context)?.shade100,
                    ),
                  ),
                ),
                if (info != null && !showInfoIcon)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.kDefaultPadding * 0.15,
                    ),
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
            ),
          ),
        ),
        const SizedBox(
          width: AppSpacing.kDefaultPadding * 0.05,
        ),
        infoIcon(context)
      ],
    );
  }

  Widget infoIcon(BuildContext context) {
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
                          const SizedBox(
                            height: AppSpacing.kDefaultPadding * 0.5,
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
              size: AppSpacing.kDefaultPadding * 1.2,
            ),
          )
        : const SizedBox(
            width: 0,
            height: 0,
          );
  }
}
