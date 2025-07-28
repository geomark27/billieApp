/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_purchases
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/import_data.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class ImportPurchasesScreen extends StatefulWidget {
  const ImportPurchasesScreen({super.key});

  @override
  State<ImportPurchasesScreen> createState() => _ImportPurchasesScreenState();
}

class _ImportPurchasesScreenState extends State<ImportPurchasesScreen> {
  String? wareHouse = "0";
  String? supplier;
  String? purchaseStatus = "received";
  late TextEditingController documentController;
  late TextEditingController fileController;

  String? orderTax = "0";
  late TextEditingController discountController;
  late TextEditingController shippingCostController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    documentController = TextEditingController();
    fileController = TextEditingController();
    discountController = TextEditingController();
    shippingCostController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    documentController.dispose();
    fileController.dispose();
    discountController.dispose();
    shippingCostController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Import Purchase",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Warehouse",
          value: wareHouse,
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              wareHouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Supplier",
          value: supplier,
          items: context.watch<CommonDataProvider>().selectSuppliersData,
          onChange: (value) {
            setState(() {
              supplier = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Purchase Status",
          value: purchaseStatus,
          items: context.watch<CommonDataProvider>().selectPurchaseStatusData,
          onChange: (value) {
            setState(() {
              purchaseStatus = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppFilePicker(
          hintText: "Document",
          allowMultiple: false,
          allowedExtensions: const [
            'jpg',
            'jpeg',
            'png',
            'gif',
            'pdf',
            'csv',
            'docx',
            'xlsx',
            'txt'
          ],
          controller: documentController,
          info:
              "Only jpg, jpeg, png, gif, pdf, csv, docx, xlsx and txt file is supported.",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding,
          ),
          child: ImportData(
            controller: fileController,
            prefix: const [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSpacing.kDefaultPadding * 0.5,
                ),
                child: Text(
                  "The correct column order is (product_code, quantity, purchase_unit_code, cost, discount_per_unit, tax_name) and you must follow this. All columns are required",
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSelect(
          hintText: "Order Tax",
          value: orderTax,
          items: context.watch<CommonDataProvider>().selectProductTaxesData,
          onChange: (value) {
            setState(() {
              orderTax = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Discount",
          controller: discountController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Shipping Cost",
          controller: shippingCostController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
