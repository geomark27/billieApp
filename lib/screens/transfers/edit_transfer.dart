/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_transfer
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditTransferScreen extends StatefulWidget {
  const EditTransferScreen({super.key});

  @override
  State<EditTransferScreen> createState() => _EditTransferScreenState();
}

class _EditTransferScreenState extends State<EditTransferScreen> {
  final List<Map<String, String>> statuses = [
    {"label": "Completed", "value": "completed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Sent", "value": "sent"},
  ];

  late TextEditingController dateController;
  String? firstWareHouse;
  String? secondWareHouse;
  String? status = "completed";
  String? product;
  late TextEditingController shippingCostController;
  late TextEditingController documentController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    shippingCostController = TextEditingController();
    documentController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    shippingCostController.dispose();
    documentController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Transfer",
      onSubmit: () {},
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
        ),
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
