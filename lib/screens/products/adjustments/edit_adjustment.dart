/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_adjustment
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditAdjustmentScreen extends StatefulWidget {
  const EditAdjustmentScreen({super.key});

  @override
  State<EditAdjustmentScreen> createState() => _EditAdjustmentScreenState();
}

class _EditAdjustmentScreenState extends State<EditAdjustmentScreen> {
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
