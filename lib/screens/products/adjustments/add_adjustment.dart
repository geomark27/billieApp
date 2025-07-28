/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_adjustment
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddAdjustmentScreen extends StatefulWidget {
  const AddAdjustmentScreen({super.key});

  @override
  State<AddAdjustmentScreen> createState() => _AddAdjustmentScreenState();
}

class _AddAdjustmentScreenState extends State<AddAdjustmentScreen> {
  String? warehouse = "0";
  late TextEditingController documentController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    documentController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    documentController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Adjustment",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Warehouse",
          value: warehouse,
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              warehouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif', 'pdf'],
          hintText: "Document",
          allowMultiple: false,
          controller: documentController,
        ),
        AppSelect(
          hintText: "Product(s)",
          items: const [],
          onChange: (value) {},
          prefix: const Icon(
            FontAwesomeIcons.barcode,
          ),
          enableFilter: false,
          enableSearch: false,
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
