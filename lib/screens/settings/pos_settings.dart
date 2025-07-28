/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: pos_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class PosSettingsScreen extends StatefulWidget {
  const PosSettingsScreen({super.key});

  @override
  State<PosSettingsScreen> createState() => _PosSettingsScreenState();
}

class _PosSettingsScreenState extends State<PosSettingsScreen> {
  String? defaultCustomer;
  String? defaultBiller;
  String? defaultWarehouse;
  late TextEditingController numberOfProductRowController;
  bool? touchScreenKeyboard = false;
  bool? tableManagement = false;
  bool? sendSMSAfterSale = true;
  String? invoiceOption = "thermal_pos_receipt";
  String? thermalInvoiceSize = "80";
  List<Map<String, dynamic>> paymentOptions = [
    {
      "title": "Cash",
      "enable": true,
    },
    {
      "title": "Card",
      "enable": true,
    },
    {
      "title": "Cash",
      "enable": true,
    },
    {
      "title": "Cheque",
      "enable": true,
    },
    {
      "title": "Gift Card",
      "enable": true,
    },
    {
      "title": "Deposit",
      "enable": true,
    },
    {
      "title": "Pesapal",
      "enable": false,
    },
    {
      "title": "Moneipoint",
      "enable": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    numberOfProductRowController = TextEditingController();
  }

  @override
  void dispose() {
    numberOfProductRowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "POS Setting",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Default Customer",
          value: defaultCustomer,
          items: const [],
          onChange: (value) {
            setState(() {
              defaultCustomer = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Default Biller",
          value: defaultBiller,
          items: const [],
          onChange: (value) {
            setState(() {
              defaultBiller = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Default Warehouse",
          value: defaultWarehouse,
          items: const [],
          onChange: (value) {
            setState(() {
              defaultWarehouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Displayed Number of Product Row",
          controller: numberOfProductRowController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "Touchscreen Keyboard",
          value: touchScreenKeyboard!,
          onChanged: (value) {
            setState(() {
              touchScreenKeyboard = value;
            });
          },
        ),
        AppCheckBox(
          hintText: "Table Management",
          value: tableManagement!,
          onChanged: (value) {
            setState(() {
              tableManagement = value;
            });
          },
        ),
        AppCheckBox(
          hintText: "Send SMS After Sale",
          value: sendSMSAfterSale!,
          onChanged: (value) {
            setState(() {
              touchScreenKeyboard = value;
            });
          },
        ),
        AppSelect(
          hintText: "Invoice Option",
          value: invoiceOption,
          items: const [
            {"label": "A4", "value": "a4"},
            {"label": "Thermal POS receipt", "value": "thermal_pos_receipt"}
          ],
          onChange: (value) {
            setState(() {
              invoiceOption = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AnimatedCrossFade(
          duration: const Duration(
            milliseconds: 700,
          ),
          firstChild: AppSelect(
            hintText: "Thermal Invoice Size",
            value: thermalInvoiceSize,
            items: const [
              {"label": "80mm", "value": "80"},
              {"label": "58mm", "value": "58"}
            ],
            onChange: (value) {
              setState(() {
                thermalInvoiceSize = value;
              });
            },
            enableFilter: false,
            enableSearch: false,
          ),
          secondChild: const SizedBox(),
          crossFadeState: invoiceOption == "a4"
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        const SizedBox(
          height: AppSpacing.kDefaultPadding,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Options",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: AppSpacing.kDefaultPadding * 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        for (int i = 0; i < paymentOptions.length; i++)
          AppCheckBox(
            hintText: paymentOptions[i]['title'],
            value: paymentOptions[i]['enable'],
            onChanged: (value) {
              setState(() {
                paymentOptions[i]['enable'] = value;
              });
            },
          ),
      ],
    );
  }
}
