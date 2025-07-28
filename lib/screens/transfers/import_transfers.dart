/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_transfers
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/import_data.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class ImportTransfersScreen extends StatefulWidget {
  const ImportTransfersScreen({super.key});

  @override
  State<ImportTransfersScreen> createState() => _ImportTransfersScreenState();
}

class _ImportTransfersScreenState extends State<ImportTransfersScreen> {
  final List<Map<String, String>> statuses = [
    {"label": "Completed", "value": "completed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Sent", "value": "sent"},
  ];

  String? firstWareHouse;
  String? secondWareHouse;
  String? status = "completed";
  late TextEditingController fileController;
  late TextEditingController shippingCostController;
  late TextEditingController documentController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    fileController = TextEditingController();
    shippingCostController = TextEditingController();
    documentController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    fileController.dispose();
    shippingCostController.dispose();
    documentController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Import Transfer",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "From Warehouse",
          value: firstWareHouse,
          items: const [
            {"label": "Shop 1", "value": "1"},
            {"label": "Shop 2", "value": "2"},
          ],
          onChange: (value) {
            setState(() {
              firstWareHouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "To Warehouse",
          value: secondWareHouse,
          items: const [
            {"label": "Shop 1", "value": "1"},
            {"label": "Shop 2", "value": "2"},
          ],
          onChange: (value) {
            setState(() {
              secondWareHouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Status",
          value: status,
          items: statuses,
          onChange: (value) {
            setState(() {
              status = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
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
                  "The correct column order is (product_code, quantity, product_unit, product_cost, tax_name) and you must follow this. All columns are required",
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppInput(
          hintText: "Shipping Cost",
          controller: shippingCostController,
          keyboardType: TextInputType.number,
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
        AppInput(
          hintText: "Note",
          controller: shippingCostController,
          multiline: true,
        ),
      ],
    );
  }
}
