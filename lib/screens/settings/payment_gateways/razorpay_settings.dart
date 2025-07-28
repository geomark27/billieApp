/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: razorpay_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class RazorpaySettings extends StatefulWidget {
  const RazorpaySettings({super.key});

  @override
  State<RazorpaySettings> createState() => _RazorpaySettingsState();
}

class _RazorpaySettingsState extends State<RazorpaySettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController keyController;
  late TextEditingController secretController;

  @override
  void initState() {
    super.initState();
    keyController = TextEditingController();
    secretController = TextEditingController();
  }

  @override
  void dispose() {
    keyController.dispose();
    secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Razorpay Details",
        style: TextStyle(
          fontSize: AppSpacing.kDefaultPadding * 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      children: generateInputGroups(
        [
          AppCheckBox(
            hintText: "Salepro",
            value: salePro!,
            onChanged: (value) {
              setState(() {
                salePro = value;
              });
            },
          ),
          AppCheckBox(
            hintText: "Ecommerce",
            value: ecommerce!,
            onChanged: (value) {
              setState(() {
                ecommerce = value;
              });
            },
          ),
          AppInput(
            hintText: "Key",
            controller: keyController,
          ),
          AppInput(
            hintText: "Secret",
            controller: secretController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
