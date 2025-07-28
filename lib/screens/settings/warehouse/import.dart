/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/import_data_screen.dart';

class ImportWarehousesScreen extends StatefulWidget {
  const ImportWarehousesScreen({super.key});

  @override
  State<ImportWarehousesScreen> createState() => _ImportWarehousesScreenState();
}

class _ImportWarehousesScreenState extends State<ImportWarehousesScreen> {
  late TextEditingController fileController;

  @override
  void initState() {
    super.initState();
    fileController = TextEditingController();
  }

  @override
  void dispose() {
    fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImportDataScreen(
      controller: fileController,
      title: "Import Warehouse",
      onSubmit: () {},
      prefix: const [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Text(
            "The correct column order is (name*, phone, email, address*) and you must follow this.",
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding,
            ),
          ),
        ),
      ],
      fileLink: "",
    );
  }
}
