/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_production
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditProductionScreen extends StatefulWidget {
  const EditProductionScreen({super.key});

  @override
  State<EditProductionScreen> createState() => _EditProductionScreenState();
}

class _EditProductionScreenState extends State<EditProductionScreen> {
  late TextEditingController dateController;
  String? wareHouse = "0";
  String? productionStatus = "received";
  late TextEditingController documentController;
  String? product;
  late TextEditingController shippingCostController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    documentController = TextEditingController();
    shippingCostController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    documentController.dispose();
    shippingCostController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Production",
      onSubmit: () {},
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
        ),
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
          hintText: "Production Status",
          value: productionStatus,
          items: const [
            {"label": "Received", "value": "received"},
          ],
          onChange: (value) {
            setState(() {
              productionStatus = value;
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
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
