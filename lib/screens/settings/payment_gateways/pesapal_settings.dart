/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: pesapal_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class PesapalSettings extends StatefulWidget {
  const PesapalSettings({super.key});

  @override
  State<PesapalSettings> createState() => _PesapalSettingsState();
}

class _PesapalSettingsState extends State<PesapalSettings> {
  bool? salePro = false;
  bool? ecommerce = true;
  String? mode = "sandbox";
  late TextEditingController consumerKeyController;
  late TextEditingController consumerSecretController;

  @override
  void initState() {
    super.initState();
    consumerKeyController = TextEditingController();
    consumerSecretController = TextEditingController();
  }

  @override
  void dispose() {
    consumerKeyController.dispose();
    consumerSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Pesapal Details",
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
            hintText: "Consumer Key",
            controller: consumerKeyController,
          ),
          AppInput(
            hintText: "Consumer Secret",
            controller: consumerSecretController,
          ),
          const SizedBox(
            height: AppSpacing.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
