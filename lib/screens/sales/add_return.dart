/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_return
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddReturnScreen extends StatefulWidget {
  const AddReturnScreen({super.key});

  @override
  State<AddReturnScreen> createState() => _AddReturnScreenState();
}

class _AddReturnScreenState extends State<AddReturnScreen> {
  String? orderTax = "0";
  late TextEditingController documentController;
  late TextEditingController returnNoteController;
  late TextEditingController staffNoteController;

  @override
  void initState() {
    super.initState();
    documentController = TextEditingController();
    returnNoteController = TextEditingController();
    staffNoteController = TextEditingController();
  }

  @override
  void dispose() {
    documentController.dispose();
    returnNoteController.dispose();
    staffNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Return",
      onSubmit: () {},
      children: [
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
          hintText: "Return Note",
          controller: returnNoteController,
          multiline: true,
        ),
        AppInput(
          hintText: "Staff Note",
          controller: staffNoteController,
          multiline: true,
        ),
      ],
    );
  }
}
