/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/import_data_screen.dart';

class ImportTaxesScreen extends StatefulWidget {
  const ImportTaxesScreen({super.key});

  @override
  State<ImportTaxesScreen> createState() => _ImportTaxesScreenState();
}

class _ImportTaxesScreenState extends State<ImportTaxesScreen> {
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
      title: "Import Tax",
      onSubmit: () {},
      prefix: const [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Text(
            "The correct column order is (name*, rate*) and you must follow this.",
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
