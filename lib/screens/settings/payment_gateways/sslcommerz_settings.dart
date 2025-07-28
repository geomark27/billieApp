/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sslcommerz_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class SSLCommerzSettings extends StatefulWidget {
  const SSLCommerzSettings({super.key});

  @override
  State<SSLCommerzSettings> createState() => _SSLCommerzSettingsState();
}

class _SSLCommerzSettingsState extends State<SSLCommerzSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController appKeyController;
  late TextEditingController appSecretController;

  @override
  void initState() {
    super.initState();
    appKeyController = TextEditingController();
    appSecretController = TextEditingController();
  }

  @override
  void dispose() {
    appKeyController.dispose();
    appSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "SSLCommerz Details",
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
            hintText: "appkey",
            controller: appKeyController,
          ),
          AppInput(
            hintText: "appsecret",
            controller: appSecretController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
