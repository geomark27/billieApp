/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: paypal_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class PaypalSettings extends StatefulWidget {
  const PaypalSettings({super.key});

  @override
  State<PaypalSettings> createState() => _PaypalSettingsState();
}

class _PaypalSettingsState extends State<PaypalSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController clientIdController;
  late TextEditingController clientSecretController;

  @override
  void initState() {
    super.initState();
    clientIdController = TextEditingController();
    clientSecretController = TextEditingController();
  }

  @override
  void dispose() {
    clientIdController.dispose();
    clientSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "PayPal Details",
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
            hintText: "Client Id",
            controller: clientIdController,
          ),
          AppInput(
            hintText: "Client Secret",
            controller: clientSecretController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
