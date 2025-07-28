/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: bkash_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class BkashSettings extends StatefulWidget {
  const BkashSettings({super.key});

  @override
  State<BkashSettings> createState() => _BkashSettingsState();
}

class _BkashSettingsState extends State<BkashSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  String? mode = "sandbox";
  late TextEditingController appKeyController;
  late TextEditingController appSecretController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    appKeyController = TextEditingController();
    appSecretController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    appKeyController.dispose();
    appSecretController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Bkash Details",
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
          AppSelect(
            hintText: "Mode",
            items: const [
              {"label": "Sandbox", "value": "sandbox"},
              {"label": "Live", "value": "live"},
            ],
            value: mode,
            onChange: (value) {
              setState(() {
                mode = value;
              });
            },
            enableFilter: false,
            enableSearch: false,
          ),
          AppInput(
            hintText: "appkey",
            controller: appKeyController,
          ),
          AppInput(
            hintText: "appsecret",
            controller: appSecretController,
          ),
          AppInput(
            hintText: "username",
            controller: userNameController,
          ),
          AppInput(
            hintText: "password",
            controller: passwordController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
