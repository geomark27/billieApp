/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: general_settings
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  late TextEditingController systemTitleController;
  late TextEditingController companyNameController;
  String? saleAndQuotationWithoutStock = "yes";
  String? currencyPosition = "prefix";
  String? invoiceFormat = "standard";
  String? expiryDurationType = "days";
  late TextEditingController logoController;
  late TextEditingController vatRegistrationController;
  String? packingSlipToManageOrdersOrSales = "enable";
  late TextEditingController digitsAfterDecimalPointController;
  String? dateFormat = "0";
  late TextEditingController expiryValueController;
  bool? rtlLayout = false;
  String? timeZone = "0";
  String? currency = "0";
  String? staffAccess = "0";
  late TextEditingController developedByController;

  @override
  void initState() {
    super.initState();
    systemTitleController = TextEditingController();
    companyNameController = TextEditingController();
    logoController = TextEditingController();
    vatRegistrationController = TextEditingController();
    digitsAfterDecimalPointController = TextEditingController();
    expiryValueController = TextEditingController();
    developedByController = TextEditingController();
  }

  @override
  void dispose() {
    systemTitleController.dispose();
    companyNameController.dispose();
    logoController.dispose();
    vatRegistrationController.dispose();
    digitsAfterDecimalPointController.dispose();
    expiryValueController.dispose();
    developedByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "General Settings",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "System Title",
          controller: systemTitleController,
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyNameController,
        ),
        AppSelect(
          hintText: "Sale and Quotation without stock",
          items: const [
            {"label": "Yes", "value": "yes"},
            {"label": "No", "value": "no"},
          ],
          value: saleAndQuotationWithoutStock,
          onChange: (value) {
            setState(() {
              saleAndQuotationWithoutStock = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Currency Position",
          items: const [
            {"label": "Prefix", "value": "prefix"},
            {"label": "Suffix", "value": "suffix"},
          ],
          value: currencyPosition,
          onChange: (value) {
            setState(() {
              currencyPosition = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Invoice Format",
          items: const [
            {"label": "Standard", "value": "standard"},
            {"label": "Indian GST", "value": "indian_gst"},
          ],
          value: invoiceFormat,
          onChange: (value) {
            setState(() {
              invoiceFormat = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Expiry Duration Type",
          items: const [
            {"label": "Days", "value": "days"},
            {"label": "Months", "value": "months"},
            {"label": "Years", "value": "years"},
          ],
          value: expiryDurationType,
          onChange: (value) {
            setState(() {
              expiryDurationType = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppFilePicker(
          hintText: "System Logo",
          controller: logoController,
          allowMultiple: false,
        ),
        AppInput(
          hintText: "VAT Registration Number",
          controller: vatRegistrationController,
        ),
        AppSelect(
          hintText: "Packing Slip to manage orders/sales",
          items: const [
            {"label": "Enable", "value": "enable"},
            {"label": "Disable", "value": "disable"},
          ],
          value: packingSlipToManageOrdersOrSales,
          onChange: (value) {
            setState(() {
              packingSlipToManageOrdersOrSales = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Digits after decimal point",
          controller: digitsAfterDecimalPointController,
          keyboardType: TextInputType.number,
        ),
        AppSelect(
          hintText: "Date Format",
          items: const [
            {"label": "dd-mm-yyyy", "value": "0"},
          ],
          value: dateFormat,
          onChange: (value) {
            setState(() {
              dateFormat = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Expiry Value",
          controller: expiryValueController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "RTL Layout",
          value: rtlLayout!,
          onChanged: (value) {
            setState(() {
              rtlLayout = value;
            });
          },
        ),
        AppSelect(
          hintText: "Time Zone",
          items: const [
            {"label": "UTC/GMT +06:00 - Asia/Dhaka", "value": "0"},
          ],
          value: timeZone,
          onChange: (value) {
            setState(() {
              timeZone = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Currency",
          items: context.watch<CommonDataProvider>().selectCurrenciesData,
          value: currency,
          onChange: (value) {
            setState(() {
              currency = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Staff Access",
          items: const [
            {"label": "All Records", "value": "0"},
            {"label": "Own Records", "value": "1"},
            {"label": "Warehouse Wise", "value": "2"},
          ],
          value: staffAccess,
          onChange: (value) {
            setState(() {
              staffAccess = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Developed By",
          controller: developedByController,
        ),
      ],
    );
  }
}
