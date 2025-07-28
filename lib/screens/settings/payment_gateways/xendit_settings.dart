/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: xendit_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';

class XenditSettings extends StatefulWidget {
  const XenditSettings({super.key});

  @override
  State<XenditSettings> createState() => _XenditSettingsState();
}

class _XenditSettingsState extends State<XenditSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  late TextEditingController secretKeyController;
  late TextEditingController callbackTokenController;

  @override
  void initState() {
    super.initState();
    secretKeyController = TextEditingController();
    callbackTokenController = TextEditingController();
  }

  @override
  void dispose() {
    secretKeyController.dispose();
    callbackTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Xendit Details",
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
            hintText: "Secret Key",
            controller: secretKeyController,
          ),
          AppInput(
            hintText: "Callback Token",
            controller: callbackTokenController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
