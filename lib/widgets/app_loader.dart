/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: app_loader
*/

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/theme_provider.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (context.watch<ThemeProvider>().isLoading)
          Container(
            decoration: BoxDecoration(
              color: AppColors.slateSwatch.withValues(
                alpha: 0.5,
              ),
            ),
            width: getScreenSize(context, type: 'width'),
            height: getScreenSize(context),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: AppSpacing.kDefaultPadding * 9,
                    height: AppSpacing.kDefaultPadding * 9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          getThemeColor(context)?.shade900.withValues(
                                    alpha: 0.5,
                                  ) ??
                              AppColors.slateSwatch.withValues(
                                alpha: 0.5,
                              ),
                          getThemeColor(context)?.shade800.withValues(
                                    alpha: 0.7,
                                  ) ??
                              AppColors.slateSwatch.withValues(
                                alpha: 0.7,
                              ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.kDefaultPadding * 1.5,
                      ),
                    ),
                  ),
                  Lottie.asset(
                    'assets/animations/loading.json',
                    width: AppSpacing.kDefaultPadding * 16,
                    height: AppSpacing.kDefaultPadding * 16,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
