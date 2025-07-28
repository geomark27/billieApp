/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: stripe_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class StripeSettings extends StatefulWidget {
  const StripeSettings({super.key});

  @override
  State<StripeSettings> createState() => _StripeSettingsState();
}

class _StripeSettingsState extends State<StripeSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController publicKeyController;
  late TextEditingController privateKeyController;

  @override
  void initState() {
    super.initState();
    publicKeyController = TextEditingController();
    privateKeyController = TextEditingController();
  }

  @override
  void dispose() {
    publicKeyController.dispose();
    privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Stripe Details",
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
            hintText: "Public Key",
            controller: publicKeyController,
          ),
          AppInput(
            hintText: "Private Key",
            controller: privateKeyController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
