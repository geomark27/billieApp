/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: form
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/button.dart';

class AppForm extends StatelessWidget {
  const AppForm({super.key, required this.children, required this.onSubmit});

  final List<Widget> children;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSpacing.kDefaultPadding,
        ),
        ...generateInputGroups(children),
        const SizedBox(
          height: AppSpacing.kDefaultPadding * 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding,
          ),
          child: AppButton(
            title: "Submit",
            onPressed: onSubmit,
          ),
        ),
        const SizedBox(
          height: AppSpacing.kDefaultPadding * 8,
        ),
      ],
    );
  }
}

List<Widget> generateInputGroups(List<Widget> children,
    {EdgeInsetsGeometry? padding}) {
  return children.map(
    (child) {
      if (child.runtimeType == AnimatedCrossFade) {
        return Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: AppSpacing.kDefaultPadding * 0.7,
              ),
          child: child,
        );
      } else {
        return Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: AppSpacing.kDefaultPadding * 0.5,
                vertical: AppSpacing.kDefaultPadding * 0.5,
              ),
          child: child,
        );
      }
    },
  ).toList();
}
