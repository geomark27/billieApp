/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: paystack_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class PaystackSettings extends StatefulWidget {
  const PaystackSettings({super.key});

  @override
  State<PaystackSettings> createState() => _PaystackSettingsState();
}

class _PaystackSettingsState extends State<PaystackSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController publicKeyController;
  late TextEditingController secretKeyController;

  @override
  void initState() {
    super.initState();
    publicKeyController = TextEditingController();
    secretKeyController = TextEditingController();
  }

  @override
  void dispose() {
    publicKeyController.dispose();
    secretKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Paystack Details",
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
            hintText: "Secret Key",
            controller: secretKeyController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
