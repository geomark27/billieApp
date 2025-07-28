/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: print_barcode
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class PrintBarcodeScreen extends StatefulWidget {
  const PrintBarcodeScreen({super.key});

  @override
  State<PrintBarcodeScreen> createState() => _PrintBarcodeScreenState();
}

class _PrintBarcodeScreenState extends State<PrintBarcodeScreen> {
  final List<Map<String, String>> paperSizes = [
    {
      "label": "20 Labels per Sheet",
      "value": "0",
    },
  ];

  String? product;
  bool? enableProductName = true;
  late TextEditingController productNameController;
  bool? enablePrice = true;
  late TextEditingController priceController;
  bool? enablePromotionalPrice = true;
  late TextEditingController promotionalPriceController;
  bool? enableBusinessName = true;
  late TextEditingController businessNameController;
  String? paperSize;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: "15");
    priceController = TextEditingController(text: "15");
    promotionalPriceController = TextEditingController(text: "15");
    businessNameController = TextEditingController(text: "15");
  }

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    promotionalPriceController.dispose();
    businessNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Print Barcode",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Product",
          value: product,
          items: const [],
          onChange: (value) {
            setState(() {
              product = value;
            });
          },
          prefix: const Icon(
            FontAwesomeIcons.barcode,
          ),
          enableFilter: false,
          enableSearch: false,
        ),
        const SizedBox(
          height: AppSpacing.kDefaultPadding * 0.5,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.kDefaultPadding,
            top: AppSpacing.kDefaultPadding,
          ),
          child: Text(
            "Information on Label",
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding * 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppCheckBox(
          hintText: "Product Name",
          value: enableProductName ?? false,
          onChanged: (value) {
            setState(() {
              enableProductName = value;
            });
          },
        ),
        AppInput(
          hintText: "Size",
          controller: productNameController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "Price",
          value: enablePrice ?? false,
          onChanged: (value) {
            setState(() {
              enablePrice = value;
            });
          },
        ),
        AppInput(
          hintText: "Size",
          controller: priceController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "Promotional Price",
          value: enablePromotionalPrice ?? false,
          onChanged: (value) {
            setState(() {
              enablePromotionalPrice = value;
            });
          },
        ),
        AppInput(
          hintText: "Size",
          controller: promotionalPriceController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "Business Name",
          value: enableBusinessName ?? false,
          onChanged: (value) {
            setState(() {
              enableBusinessName = value;
            });
          },
        ),
        AppInput(
          hintText: "Size",
          controller: businessNameController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: AppSpacing.kDefaultPadding * 0.5,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.kDefaultPadding,
            top: AppSpacing.kDefaultPadding,
          ),
          child: Text(
            "Paper Size",
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding * 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppSelect(
          hintText: "Paper Size",
          value: paperSize,
          items: paperSizes,
          onChange: (value) {
            setState(() {
              paperSize = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
      ],
    );
  }
}
